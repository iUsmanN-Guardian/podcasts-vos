//
//  Misc.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 29/12/2023.
//

import Foundation

func formatSecondsToMinutesAndSeconds(seconds: Double) -> String {
    let totalSeconds = Int(seconds)
    let minutes = totalSeconds / 60
    let remainingSeconds = totalSeconds % 60
    
    return String(format: "%02d:%02d", minutes, remainingSeconds)
}
