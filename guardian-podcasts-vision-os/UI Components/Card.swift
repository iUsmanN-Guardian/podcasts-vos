//
//  Card.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import SwiftUI

struct Card: View {
    
    @State var data: PodcastModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(data.series)
                .resizable()
                .frame(width: 220, height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 9))
            Text(data.series)
                .font(.custom("GuardianTextEgyptian-Bold", size: 23))
            Text(data.title)
                .font(.custom("GuardianTextEgyptian-Med", size: 25))
                .truncationMode(.tail)
                .lineLimit(5, reservesSpace: true)
        }
        .frame(width: 220)
    }
}

#Preview {
    Card(data: .sample)
        .border(.white)
}
