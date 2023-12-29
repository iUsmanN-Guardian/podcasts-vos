//
//  Cell.swift
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
            Text(formatSecondsToMinutesAndSeconds(seconds: data.duration))
                .font(.system(size: 30))
                .bold()
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
    }
}

#Preview {
    Cell(data: .sample)
}
