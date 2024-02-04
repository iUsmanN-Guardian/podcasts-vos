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

func heightToBlur(input: Double) -> Double {
    // Calculated slope and y-intercept
    let m = -0.002857142857142857
    let b = 1.7142857142857144
    
    // Calculate the preliminary output without clamping
    let output = m * input + b
    
    // Clamp the result to be between 0 and 1
    return min(max(output, 0), 1)
}
