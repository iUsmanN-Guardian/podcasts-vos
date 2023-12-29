//
//  PodcastSeries.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import Foundation

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
}

enum PodcastLayout: String, Hashable {
    case list
    case tiles
}
