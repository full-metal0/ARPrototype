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
    
    // TODO: Research lazy ver implementation
    lazy var persistenceUrl: URL = {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("arf.persistence")
        } catch {
            fatalError("Unable to get persistenceUrl: \(error.localizedDescription)")
        }
    }()
    
    var scenePersistenceData: Data? {
        return try? Data(contentsOf: persistenceUrl)
    }
}
