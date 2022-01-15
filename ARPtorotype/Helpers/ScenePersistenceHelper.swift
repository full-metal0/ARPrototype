//
//  ScenePersistenceHelper.swift
//  ARPtorotype
//
//  Created by Kaligula on 15.01.2022.
//

import Foundation
import RealityKit
import ARKit

class ScenePersistenceHelper {
    class func saveScene(for arView: CustomARView, at persistenceUrl: URL) {
        print("Save scene to the local filesystem")
        
        arView.session.getCurrentWorldMap { worldMap, error in
            guard let map = worldMap else {
                // TODO: create a notification for user
                print("Persistence Error: Unable to get worldMap: \(error!.localizedDescription)")
                
                return
            }
            
            // archive data and write to filesystem
            do {
                let sceneData = try NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                
                try sceneData.write(to: persistenceUrl, options: [.atomic])
            } catch {
                print("Persistence Error: Can't save scene to local filesystem: \(error.localizedDescription)")
            }
        }
    }
    
    class func loadScene(for arView: CustomARView, with scenePersistenceData: Data) {
        print("Load scene from the local filesystem")
        
        let worldMap: ARWorldMap = {
            do {
                guard let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: scenePersistenceData) else {
                    fatalError("Persistence Error: No ARWorldMap in arhive")
                }
                
                return worldMap
            } catch {
                fatalError("Persistence Error: Unable to unarchive ARWorldMap from scenePeristenceData: \(error.localizedDescription)")
            }
        }()
        
        // Reset config and load worldMap as initialWorldMap
        let newConfiguration = arView.defaultConfiguration
        newConfiguration.initialWorldMap = worldMap
        
        arView.session.run(newConfiguration, options: [.resetTracking, .removeExistingAnchors])
    }
}
