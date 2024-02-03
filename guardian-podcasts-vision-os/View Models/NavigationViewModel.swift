//
//  NavigationViewModel.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 29/12/2023.
//

import Foundation
import SwiftUI
import Robin

class NavigationViewModel: ObservableObject {
    @Published var activePodcast: PodcastModel?
    @ObservedObject var robin: Robin = .shared
    
    var isShowingMiniplayer: Bool = false {
        didSet {
            if isShowingMiniplayer == false {
                robin.pause()
            }
        }
    }
}
