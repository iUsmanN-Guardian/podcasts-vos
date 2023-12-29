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
    @State private var layout: PodcastLayout = .tiles
    
    @State private var data: [PodcastModel] = []
    
    @ObservedObject var robin: Robin = .shared
    
    var body: some View {
        VStack {
            VStack {
                Masthead(series: $series, layout: $layout)
                    .frame(height: 150)
            }
            .padding(.top, 20)
            .padding(.horizontal, 50)
            Divider()
            
            if layout == .tiles {
                TileView(data: $data)
                    .environmentObject(navVM)
            } else {
                ListView(data: $data, series: $series)
                    .environmentObject(navVM)
            }
            Spacer()
        }
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
            let result = list.cards.map({PodcastModel(series: $0.item.metadata.series.title, title: $0.item.title, url: URL(string: $0.item.audio.adFreeUri), duration: Double($0.item.audio.durationInSeconds))})
            withAnimation(.spring()) {
                data = result
            }
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
