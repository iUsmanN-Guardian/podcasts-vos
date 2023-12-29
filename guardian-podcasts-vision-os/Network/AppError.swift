//
//  AppError.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import Foundation

enum AppError: Error {
    case networkEngineFailure
    case networkResponseFailure
    case networkStatusCodeFailure
    case networkDecodingFailure
}
