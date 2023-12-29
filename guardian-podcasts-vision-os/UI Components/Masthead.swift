//
//  Masthead.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import SwiftUI
import Robin

struct Masthead: View, PodcastService {
    var body: some View {
        HStack {
            Image("GuardianLogo")
                .resizable()
                .frame(width: 210, height: 70)
            Spacer()
        }
        .padding(.vertical, 30)
    }
}

#Preview {
    Masthead()
        .border(.white)
}
