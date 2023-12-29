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
}

struct Audio: Codable {
    var adFreeUri: String
}

struct PodcastModel: Hashable {
    var series: String
    var title: String
    var url: URL?
    
    static let sample: PodcastModel = .init(series: "Podcast",
                                            title: "Sample Title of the podcast",
                                            url: URL(string: "https://audio.guim.co.uk/2023/12/24-46070-gfw241223.mp3"))
}
