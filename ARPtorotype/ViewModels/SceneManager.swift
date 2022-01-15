//
//  SceneManager.swift
//  ARPtorotype
//
//  Created by Kaligula on 15.01.2022.
//

import SwiftUI
import RealityKit

class SceneManager: ObservableObject {
    @Published var isPersistenceAvailable: Bool = false
    // Property keeps track of anchorEntities in the scene
    @Published var anchorEntities: [AnchorEntity] = []
}
