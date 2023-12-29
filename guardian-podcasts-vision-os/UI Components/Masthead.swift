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
    
    var body: some View {
        HStack {
            Image("GuardianLogo")
                .resizable()
                .frame(width: 270, height: 90)
            Spacer()
            SeriesPicker(series: $series)
        }
        .padding(.vertical, 30)
        .padding(.top, 30)
    }
}

#Preview {
    Masthead(series: .constant(.allPodcasts))
        .border(.white)
}
