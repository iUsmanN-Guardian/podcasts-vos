//
//  ListView.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 29/12/2023.
//

import SwiftUI
import Robin

struct Cell: View {
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "play.fill")
                .font(.system(size: 30))
            Text("Today in Focus")
                .font(.custom("GuardianTextEgyptian-Med", size: 32))
                .padding(.bottom, 5)
            Spacer()
            Text("25:10")
                .font(.system(size: 23))
                .bold()
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
        .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 9))
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
                Image("Podcasts")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 9))
                HStack {
                    Text("Today in Focus")
                        .font(.custom("GuardianTextEgyptian-Bold", size: 42))
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .frame(width: 250)
                Spacer()
            }
            Divider()
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    Cell()
                    Cell()
                    Cell()
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(.top, 50)
        .padding(.horizontal, 50)
    }
}

#Preview {
    ListView(data: .constant([.sample]))
}
