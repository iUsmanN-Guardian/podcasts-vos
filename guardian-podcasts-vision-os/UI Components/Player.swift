//
//  Player.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import SwiftUI
import Robin

struct Player: View {
    
    @Environment(\.openWindow) private var openWindow
    
    @EnvironmentObject var navVM: NavigationViewModel
    
    @ObservedObject var robin: Robin = .shared
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .bottom) {
                Image(navVM.activePodcast?.series ?? "")
                    .resizable()
                    .blur(radius: heightToBlur(input: geometry.size.height)*20)
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(navVM.activePodcast?.series ?? "")
                                .font(.custom("GuardianTextEgyptian-Bold", size: 32))
                            Text(navVM.activePodcast?.title ?? "")
                                .font(.custom("GuardianTextEgyptian-Med", size: 32))
                            Spacer()
                        }
                        .frame(height: 180)
                        .contentTransition(.numericText())
                        .padding(.leading, 5)
                        Spacer()
                        Button(action: {
                            if robin.currentState == .playing {
                                robin.pause()
                            } else {
                                robin.play()
                            }
                        }, label: {
                            if robin.currentState != .playing && robin.currentState != .paused {
                                ProgressView()
                            } else {
                                Image(systemName: robin.currentState == .playing ? "pause.fill" : "play.fill")
                                    .font(.system(size: 70))
                                    .padding(8)
                                    .contentShape(.hoverEffect, RoundedRectangle(cornerRadius: 10))
                                    .hoverEffect()
                            }
                        })
                        .buttonStyle(.plain)
                        .frame(width: 130)
                        .padding(.trailing, 10)
                    }
                    .padding([.horizontal, .top])
                    HStack {
                        Spacer()
                        RectSlider()
                        Spacer()
                    }
                    .padding(.top, -12)
                    Spacer()
                }
                .frame(width: 600, height: 250)
                .background(.regularMaterial)
            }
        }
        .ornament(visibility: navVM.isShowingMainWindow ? .hidden : .visible, attachmentAnchor: .scene(.topTrailing), contentAlignment: .bottom, ornament: {
            Button(action: {
                navVM.isShowingMainWindow = true
                openWindow(id: "Main")
            }, label: {
                Image(systemName: "arrow.up.right.bottomleft.rectangle.fill")
                    .hoverEffect()
            })
        })
        .onDisappear {
            navVM.isShowingMiniplayer = false
        }
        .onAppear {
            navVM.isShowingMiniplayer = true
        }
    }
}


struct RectSlider : View {
    
    @State var sliderOffset: CGFloat = 16.1
    
    @ObservedObject var robin: Robin = .shared
    
    @State var isEditing = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 550, height: 15)
                .foregroundStyle(.white.opacity(0.6))
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 100, height: 35)
                    Text("\(formatSecondsToMinutesAndSeconds(seconds: isEditing ? ((sliderOffset-16)/467.0)*robin.audioLength : robin.elapsedTime))")
                        .foregroundStyle(.black)
                        .font(.system(size: 25))
                        .bold()
                }
                .offset(x: sliderOffset)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ value in
                            if !isEditing { isEditing = true }
                            let newValue = sliderOffset + value.velocity.width*0.005
                            print(newValue)
                            guard newValue > 16 && newValue < 467 else { return }
                            sliderOffset = newValue
                        })
                        .onEnded({ value in
                            Task {
                                await robin.seek(to:((sliderOffset-16)/467.0)*robin.audioLength)
                                isEditing = false
                            }
                        })
                )
                Spacer()
            }
        }
        .onChange(of: robin.elapsedTime) { oldValue, newValue in
            guard !isEditing else { return }
            sliderOffset = 16 + (robin.elapsedTime/robin.audioLength) * 467
        }
    }
}

#Preview {
    @StateObject var navVM = NavigationViewModel()
    
    return Player()
        .environmentObject(navVM)
}
