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
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 9))
            Text(data.series)
                .font(.custom("GuardianTextEgyptian-Bold", size: 23))
            Text(data.title)
                .font(.custom("GuardianTextEgyptian-Med", size: 25))
                .truncationMode(.tail)
                .lineLimit(3, reservesSpace: true)
        }
        .frame(width: 200)
    }
}

#Preview {
    Card(data: .sample)
        .border(.white)
}
