//
//  guardian_podcasts_vision_osApp.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import SwiftUI

@main
struct guardian_podcasts_vision_osApp: App {
    
    @StateObject var navVM = NavigationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navVM)
                .frame(
                    minWidth: 1100, maxWidth: 1100,
                    minHeight: 1060, maxHeight: 1060)
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "Player") {
            Player()
                .environmentObject(navVM)
                .frame(
                    minWidth: 600, maxWidth: 600,
                    minHeight: 600, maxHeight: 600)
        }
        .windowResizability(.contentSize)
    }
}
