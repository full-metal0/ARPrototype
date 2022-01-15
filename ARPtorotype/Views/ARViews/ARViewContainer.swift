//
//  ARViewContainer.swift
//  ARPtorotype
//
//  Created by Kaligula on 10.01.2022.
//

import RealityKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var placementSettings: PlacementSettings
    @EnvironmentObject var sessionSettings: SessionSettings
    @EnvironmentObject var sceneManager: SceneManager
    
    func makeUIView(context: Context) -> CustomARView {
        
        let arView = CustomARView(frame: .zero, sessionSettings: sessionSettings)
        
        placementSettings.sceneObserver = arView.scene
            .subscribe(to: SceneEvents.Update.self, { (event) in
                updateScene(for: arView)
                updatePersistenceAvailability(for: arView)
            })
        
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
    
    private func updateScene(for arView: CustomARView) {
        arView.focusEntity?.isEnabled = placementSettings.selectedModel != nil
        
        if let confirmedModel = placementSettings.confirmedModel,
            let modelEntity = confirmedModel.modelEntity {
            
            self.setToPlace(modelEntity, in: arView)
            print("Place")
            
            placementSettings.confirmedModel = nil
        }
    }
    
    private func setToPlace(_ modelEntity: ModelEntity, in arView: ARView) {
        // Create a copy of modelEntity and references the same model
        let cloneEntity = modelEntity.clone(recursive: true)
        
        // Create the shape used to detect collisions between two entities that have collision components.
        cloneEntity.generateCollisionShapes(recursive: true)
        
        // Enable rotation and translation gestures
        arView.installGestures([.rotation, .translation], for: cloneEntity)
        
        // Create an anchorEntity and add cloneEntity to it
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(cloneEntity)
        
        arView.scene.addAnchor(anchorEntity)
        
        sceneManager.anchorEntities.append(anchorEntity)
        
        print("Model is added")
    }
}

extension ARViewContainer {
    private func updatePersistenceAvailability(for arView: ARView) {
        guard let currentFrame = arView.session.currentFrame else {
            print("ARFrame is not available")
            return
        }
        
        switch currentFrame.worldMappingStatus {
        case .mapped, .extending:
            sceneManager.isPersistenceAvailable = !sceneManager.anchorEntities.isEmpty
        default:
            sceneManager.isPersistenceAvailable = false
        }
    }
}
