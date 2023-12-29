//
//  ContentView.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent
import Robin

struct ContentView: View, PodcastService {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @EnvironmentObject var navVM: NavigationViewModel
    
    @State private var series: PodcastSeries = .allPodcasts
    @State private var data: [PodcastModel] = []
    
    @ObservedObject var robin: Robin = .shared
    
    let layout = [
        GridItem(.fixed(400), spacing: -20),
        GridItem(.fixed(400))
    ]
    
    var body: some View {
        VStack {
            Masthead()
            SeriesPicker(series: $series)
            ScrollView(.horizontal) {
                LazyHGrid(rows: layout, spacing: 40, content: {
                    ForEach(0..<data.count, id: \.self) { i in
                        Card(data: data[i])
                            .onTapGesture { _ in
                                if navVM.activePodcast == nil {
                                    openWindow(id: "Player")
                                }
                                navVM.activePodcast = data[i]
                                robin.loadSingle(source: .init(url: data[i].url!,
                                                               metadata: RobinAudioMetadata(title: data[i].title,
                                                                                            artist: data[i].series)))
                            }
                    }
                })
                .id(data)
            }
            .id(data)
            .padding(.vertical)
            .padding(.top)
        }
        .padding()
        .padding(.horizontal, 30)
        .task {
            //load initial data
            await refreshData()
        }
        .onChange(of: series) {
            // reload data
            Task {
                await refreshData()
            }
        }
    }
    
    func refreshData() async {
        switch await fetchPodcastData(podcast: series) {
        case .success(let list):
            let series = list.title
            let result = list.cards.map({PodcastModel(series: series, title: $0.item.title, url: URL(string: $0.item.audio.adFreeUri))})
            data = result
            print("$$ \(data)")
        case .failure(let error):
            print("failure")
        }
    }
}

#Preview(windowStyle: .automatic) {
    
    @StateObject var navVM = NavigationViewModel()
    
    return ContentView()
        .frame(height: 500)
        .environmentObject(navVM)
}
