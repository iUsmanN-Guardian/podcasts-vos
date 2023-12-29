//
//  SeriesPicker.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import SwiftUI

struct SeriesPicker: View {
    
    @Binding var series: PodcastSeries
    
    var body: some View {
        Picker("Series", selection: $series) {
            Text("All Podcasts").tag(PodcastSeries.allPodcasts)
            Text("Today in Focus").tag(PodcastSeries.todayInFocus)
            Text("Football Weekly").tag(PodcastSeries.footballWeekly)
            Text("Science Weekly").tag(PodcastSeries.scienceWeekly)
//            Text("Audio Long Reads").tag(PodcastSeries.audioLongReads)
//            Text("Politics Weekly UK").tag(PodcastSeries.politicsWeeklyUK)
//            Text("Politics Weekly America").tag(PodcastSeries.politicsWeeklyAmerica)
//            Text("Pop Culture").tag(PodcastSeries.popCulture)
//            Text("Weekend").tag(PodcastSeries.weekend)
//            Text("Guardian Books").tag(PodcastSeries.guardianBooks)
//            Text("Australian Politics").tag(PodcastSeries.australianPolitics)
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    SeriesPicker(series: .constant(PodcastSeries.todayInFocus))
        .border(.white)
}
