//
//  Endpoint.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import Foundation

struct Endpoint {
    var scheme  : Networking.Scheme
    var host    : Networking.Host
    var path    : Networking.Path
    var method  : Networking.HTTPMethod
    var parameters  : [String:String]?
    var body: [String:Any]?
}
