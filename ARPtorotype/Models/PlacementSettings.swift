//
//  PlacementSettings.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    
    // Property is set, when model is selected in BrowseView
    @Published var selectedModel: ARModel? {
        willSet(newValue) {
            print("Setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    // Property selectedModel is assigned to confirmedModel, when confirm button is tapped in PlacementView
    @Published var confirmedModel: ARModel? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmed")
                return
            }
            
            print("Setting confirmedModel to \(model.name)")
        }
    }
}
