//
//  ARViewContainer.swift
//  ARPtorotype
//
//  Created by Kaligula on 10.01.2022.
//

import RealityKit
import SwiftUI
import ARKit

// global property to distinguish our anchors from the system anchors
private let anchorNamePrefix = "model-"

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var placementSettings: PlacementSettings
    @EnvironmentObject var sessionSettings: SessionSettings
    @EnvironmentObject var sceneManager: SceneManager
    @EnvironmentObject var arModelsViewModel: ARModelsViewModel
    
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero, sessionSettings: sessionSettings)
        
        arView.session.delegate = context.coordinator
        
        placementSettings.sceneObserver = arView.scene
            .subscribe(to: SceneEvents.Update.self, { (event) in
                updateScene(for: arView)
                updatePersistenceAvailability(for: arView)
                handlePersistence(for: arView)
            })
        
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
    
    private func updateScene(for arView: CustomARView) {
        arView.focusEntity?.isEnabled = placementSettings.selectedModel != nil
        
        if let arModelAnchor = placementSettings.arModelsConfirmedForPlacement.popLast(),
           let modelEntity = arModelAnchor.model.modelEntity {
            
            // TODO: Refactor branching implementation
            if let anchor = arModelAnchor.anchor {
                setToPlace(modelEntity, for: anchor, in: arView)
                
                arView.session.add(anchor: anchor)
                
                placementSettings.recentlyPlaced.append(arModelAnchor.model)
            } else if let transform = getTransformForPlacement(in: arView) {
                let anchorName = anchorNamePrefix + arModelAnchor.model.name
                let anchor = ARAnchor(name: anchorName, transform: transform)
                
                setToPlace(modelEntity, for: anchor, in: arView)
                
                arView.session.add(anchor: anchor)
                
                placementSettings.recentlyPlaced.append(arModelAnchor.model)
            }
            
        }
    }
    
    private func setToPlace(_ modelEntity: ModelEntity, for anchor: ARAnchor, in arView: ARView) {
        // Create a copy of modelEntity and references the same model
        let cloneEntity = modelEntity.clone(recursive: true)
        
        // Create the shape used to detect collisions between two entities that have collision components.
        cloneEntity.generateCollisionShapes(recursive: true)
        
        // Enable rotation and translation gestures
        arView.installGestures([.rotation, .translation], for: cloneEntity)
        
        // Create an anchorEntity and add cloneEntity to it
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(cloneEntity)
        
        // describe how the virtual content is anchored to the real world surface
        anchorEntity.anchoring = AnchoringComponent(anchor)
        
        arView.scene.addAnchor(anchorEntity)
        
        sceneManager.anchorEntities.append(anchorEntity)
        
        print("Model is added")
    }
    
    // method handles the raycasting to find the transform needed for placing an object in the scene, return 4x4 matrix
    private func getTransformForPlacement(in arView: ARView) -> simd_float4x4? {
        guard let query = arView.makeRaycastQuery(from: arView.center, allowing: .estimatedPlane, alignment: .any) else {
            return nil
        }
        
        // get a nearest intersection with a real world surface
        guard let raycastResult = arView.session.raycast(query).first else {
            return nil
        }
        
        return raycastResult.worldTransform
    }
}

// MARK: - Persistence
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
    
    private func handlePersistence(for arView: CustomARView) {
        if sceneManager.shouldSaveSceneToFilesystem {
            ScenePersistenceHelper.saveScene(for: arView, at: sceneManager.persistenceUrl)
            
            sceneManager.shouldSaveSceneToFilesystem = false
        }
        
        if sceneManager.shouldLoadSceneFromFilesystem {
            guard let scenePersistenceData = sceneManager.scenePersistenceData else {
                print("Unable to retrieve scenePersistenceData")
                
                return
            }
            
            ScenePersistenceHelper.loadScene(for: arView, with: scenePersistenceData)
            
            // clear anchor entities array
            sceneManager.anchorEntities.removeAll(keepingCapacity: true)
            
            sceneManager.shouldLoadSceneFromFilesystem = false
        }
    }
}

// MARK: - ARSessionDelegate + Coordinator
extension ARViewContainer {
    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ARViewContainer
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                if let anchorName = anchor.name, anchorName.hasPrefix(anchorNamePrefix) {
                    let modelName = anchorName.dropFirst(anchorNamePrefix.count) // delete prefix
                    
                    print("ARSession: didAdd anchor for model - \(modelName)")
                    
                    guard let model = parent.arModelsViewModel.arModels.first(where: { $0.name == modelName }) else {
                        print("Unable to retrieve model from arModelViewModel")
                        
                        return
                    }
                    
                    model.asyncLoadARModelEntity { completed, error in
                        if completed {
                            let arModelAnchor = ARModelAnchor(model: model, anchor: anchor)
                            self.parent.placementSettings.arModelsConfirmedForPlacement.append(arModelAnchor)
                            
                            print("Adding arModelAnchor - \(modelName)")
                        }
                    }
                }
            }
        }
    }
    
    // method is automaticaly called by SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
