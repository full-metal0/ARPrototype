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
            
            self.recentlyPlaced.append(model)
            
            print("Setting confirmedModel to \(model.name)")
        }
    }
    
    // Property - container for cancellable objects of SceneEvents.Update subscriber 
    var sceneObserver: Cancellable?
    
    // Property stores a record of placed ar models in the scene, the last element is the most recently placed ar model.
    @Published var recentlyPlaced: [ARModel] = []
}
