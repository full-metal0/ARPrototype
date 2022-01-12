//
//  ARPrototypeAP.swift
//  ARPtorotype
//
//  Created by Kaligula on 10.01.2022.
//

import SwiftUI

@main
struct ARPrototypeAP: App {
    @StateObject var placementSettings = PlacementSettings()
    @StateObject var sessionSettings = SessionSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
                .environmentObject(sessionSettings)
        }
    }
}

