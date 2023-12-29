//
//  TileView.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 29/12/2023.
//

import SwiftUI
import Robin

struct TileView: View {
    
    @Environment(\.openWindow) private var openWindow
    
    @EnvironmentObject var navVM: NavigationViewModel
    
    @Binding private var data: [PodcastModel]
    
    @ObservedObject var robin: Robin = .shared
    
    let gridLayout = [
        GridItem(.fixed(450))
    ]
    
    init(data: Binding<[PodcastModel]>) {
        self._data = data
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridLayout, spacing: 40, content: {
                ForEach(0..<data.count, id: \.self) { i in
                    Card(data: data[i])
                        .onTapGesture { _ in
                            if navVM.activePodcast == nil {
                                openWindow(id: "Player")
                            }
                            withAnimation(.spring()) {
                                navVM.activePodcast = data[i]
                            }
                            
                            robin.loadSingle(source: .init(url: data[i].url!,
                                                           metadata: RobinAudioMetadata(title: data[i].title,
                                                                                        artist: data[i].series)))
                        }
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.75)
                                .blur(radius: phase.isIdentity ? 0 : 10)
                                .scaleEffect(phase.isIdentity ? CGSize(width: 1, height: 1) : CGSize(width: 0.95, height: 0.95))
                        }
                }
            })
            .id(data)
        }
        .id(data)
        .padding(.top, -25)
        .contentMargins(50, for: .scrollContent)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    TileView(data: .constant([.sample]))
}
