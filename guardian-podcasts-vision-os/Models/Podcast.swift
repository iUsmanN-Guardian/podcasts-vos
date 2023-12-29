//
//  Podcast.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import Foundation

struct List: Codable {
    var title: String
    var cards: [CardItem]
}

struct CardItem: Codable {
    var item: Podcast
}

struct Podcast: Codable {
    var title: String
    var audio: Audio
    var metadata: Metadata
}

struct Audio: Codable {
    var adFreeUri: String
    var durationInSeconds: Int
}

struct Metadata: Codable {
    var series: Series
}

struct Series: Codable {
    var title: String
}

struct PodcastModel: Hashable {
    var series: String
    var title: String
    var url: URL?
    var duration: Double
    
    static let sample: PodcastModel = .init(series: "Podcast",
                                            title: "Sample Title of the podcast",
                                            url: URL(string: "https://audio.guim.co.uk/2023/12/24-46070-gfw241223.mp3"), duration: 10.0)
}
