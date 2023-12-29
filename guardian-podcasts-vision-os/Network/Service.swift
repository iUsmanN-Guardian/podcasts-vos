//
//  Service.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import Foundation

protocol PodcastService: NetworkEngine {}

extension PodcastService {
    
    func fetchPodcastData(podcast: PodcastSeries) async -> Result<List, AppError> {
        let endpoint = Endpoint(scheme: .https, host: .baseUrl, path: getSeriesPath(series: podcast), method: .get)
        return await networkRequest(endpoint: endpoint)
    }
    
    func getSeriesPath(series: PodcastSeries) -> Networking.Path {
        switch series {
        case .allPodcasts:
            return .allPodcasts
        case .todayInFocus:
            return .todayInFocus
        case .footballWeekly:
            return .footballWeekly
        case .scienceWeekly:
            return .scienceWeekly
        case .audioLongReads:
            return .audioLongReads
        case .politicsWeeklyAmerica:
            return .politicsWeeklyAmerica
        default:
            return .allPodcasts
            
            //        case .politicsWeeklyUK:
            //            <#code#>
            
            //        case .popCulture:
            //            <#code#>
            //        case .weekend:
            //            <#code#>
            //        case .guardianBooks:
            //            <#code#>
            //        case .australianPolitics:
            //            <#code#>
        }
    }
}
