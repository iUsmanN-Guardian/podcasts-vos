//
//  ListView.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 29/12/2023.
//

import SwiftUI
import Robin

struct Cell: View {
    
    @State var data: PodcastModel
    
    @ObservedObject var robin: Robin = .shared
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: ((robin.currentMedia?.url.absoluteString ?? "") == (data.url?.absoluteString ?? "") && robin.currentState == .playing) ? "pause.fill" : "play.fill")
                .font(.system(size: 40))
            Text(data.title)
                .font(.custom("GuardianTextEgyptian-Med", size: 26))
                .padding(.bottom, 5)
            Spacer()
            Text("25:10")
                .font(.system(size: 30))
                .bold()
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
    }
}

struct ListView: View {
    
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
        HStack(spacing: 20) {
            VStack(alignment: .leading) {
                Image(data.first?.series ?? "Podcasts")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 9))
                HStack {
                    Text(data.first?.series ?? "Podcasts")
                        .font(.custom("GuardianTextEgyptian-Bold", size: 42))
                        .multilineTextAlignment(.leading)
                        .contentTransition(.numericText())
                    Spacer()
                }
                .frame(width: 250)
                Spacer()
            }
            Divider()
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    ForEach(0..<data.count, id: \.self) { i in
                        Cell(data: data[i])
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
                                    .opacity(phase.isIdentity ? 1.0 : 0.5)
                                    .blur(radius: phase.isIdentity ? 0 : 10)
                                    .scaleEffect(phase.isIdentity ? CGSize(width: 1,height: 1) : CGSize(width: 0.95,height: 0.95))
                            }
                        Divider()
                    }
                    Spacer()
                }
                .id(data)
            }
            .id(data)
            .scrollIndicators(.hidden)
            Spacer()
        }
        .padding(.top, 50)
        .padding(.horizontal, 50)
    }
}

#Preview {
    ListView(data: .constant([.sample]))
}
