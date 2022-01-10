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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}

