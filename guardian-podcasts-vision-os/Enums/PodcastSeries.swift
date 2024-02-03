//
//  PodcastSeries.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import Foundation
import SwiftUI

enum PodcastSeries: String, Hashable {
    case allPodcasts
    case todayInFocus
    case footballWeekly
    case comfortEating
    case audioLongReads
    case politicsWeeklyUK
    case politicsWeeklyAmerica
    case popCulture
    case weekend
    case guardianBooks
    case australianPolitics
    case scienceWeekly
    
    var tintColor: Color {
        switch self {
        case .allPodcasts:
            return .clear
        case .todayInFocus:
            return .pink
        case .footballWeekly:
            return .yellow
        case .comfortEating:
            return .orange
        case .audioLongReads:
            return .white
        case .politicsWeeklyUK:
            return .blue
        case .politicsWeeklyAmerica:
            return .blue
        default:
            return .clear
        }
    }
}

enum PodcastLayout: String, Hashable {
    case list
    case tiles
}
