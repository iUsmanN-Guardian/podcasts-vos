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
                    .frame(height: 200)
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
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 520, height: 10)
                Spacer()
            }
            .frame(width: 600, height: 260)
            .background(.regularMaterial)
        }
    }
}

#Preview {
    @StateObject var navVM = NavigationViewModel()
    
    return Player()
        .environmentObject(navVM)
}
