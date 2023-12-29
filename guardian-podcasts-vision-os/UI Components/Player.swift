//
//  Player.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import SwiftUI
import Robin

struct Player: View {
    
    @EnvironmentObject var navVM: NavigationViewModel
    
    @ObservedObject var robin: Robin = .shared
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(navVM.activePodcast?.series ?? "")
                .resizable()
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
                        Image(systemName: robin.currentState == .playing ? "pause.fill" : "play.fill")
                            .font(.extraLargeTitle)
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
}


struct RectSlider : View {
    
    @State var sliderOffset: CGFloat = 16.1
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 550, height: 10)
                .foregroundStyle(.white.opacity(0.6))
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 100, height: 35)
                    Text("\(sliderOffset/467)")
                        .foregroundStyle(.black)
                }
                .offset(x: sliderOffset)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ value in
                            
                            let newValue = sliderOffset + value.velocity.width*0.005
                            print(newValue)
                            guard newValue > 16 && newValue < 467 else { return }
                            sliderOffset = newValue
                        })
                )
                Spacer()
            }
        }
    }
    
    func updateSlider(offset: CGFloat) {
        sliderOffset = offset
    }
}

#Preview {
    @StateObject var navVM = NavigationViewModel()
    
    return Player()
        .environmentObject(navVM)
}
