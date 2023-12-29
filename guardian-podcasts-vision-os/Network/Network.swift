//
//  Network.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import Foundation

enum Networking {
    
    enum Host: String {
        case baseUrl = "mobile.guardianapis.com"
    }
    
    enum Scheme: String {
        case https = "https"
        case http = "http"
    }
    
    enum Path {
        case allPodcasts
        case todayInFocus
        case footballWeekly
        case scienceWeekly
        
        var rawValue: String {
            switch self {
            case .allPodcasts:
                return "/uk/groups/collections/89fe8ce0-1a88-4cc8-917b-b7af9a407d9c"
            case .todayInFocus:
                return "/lists/tag/news/series/todayinfocus"
            case .footballWeekly:
                return "/lists/tag/football/series/footballweekly"
            case .scienceWeekly:
                return "/lists/tag/science/series/science"
            default:
                return "/lists/tag/football/series/footballweekly"
            }
        }
    }
    
    enum HTTPMethod : String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
    }
}
