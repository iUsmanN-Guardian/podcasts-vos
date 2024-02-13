//
//  Masthead.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import SwiftUI
import Robin

struct Masthead: View {
    
    @Binding var series: PodcastSeries
    @Binding var layout: PodcastLayout
    
    var body: some View {
        HStack {
            Image("GuardianLogo")
                .resizable()
                .frame(width: 340, height: 90)
            Spacer()
            VStack(alignment: .trailing, spacing: 20) {
                Picker("Layout", selection: $layout) {
                    Image(systemName: "list.bullet").tag(PodcastLayout.list)
                    Image(systemName: "square.grid.3x2.fill").tag(PodcastLayout.tiles)
                }
                .animation(.spring, value: layout)
                .pickerStyle(.segmented)
                .frame(width: 165)
                SeriesPicker(series: $series)
            }
        }
        .padding(.vertical, 30)
        .padding(.top, 20)
    }
}

#Preview {
    Masthead(series: .constant(.allPodcasts), layout: .constant(.tiles))
        .border(.white)
}
