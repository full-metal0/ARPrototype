//
//  ARModelDeletionManager.swift
//  ARPtorotype
//
//  Created by Kaligula on 16.01.2022.
//

import SwiftUI
import RealityKit

class ARModelDeletionManager: ObservableObject {
    @Published var entitySelectedFromDeletion: ModelEntity? = nil {
        willSet {
            if entitySelectedFromDeletion == nil, let newSelectedModelEntity = newValue {
                print("newSelectedModelEntity, no prior selection")
                
                // highlight newSelectedModelEntity
                let component = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)
                newSelectedModelEntity.modelDebugOptions = component
            } else if let previousSelectedModelEntity = entitySelectedFromDeletion,
                      let newSelectedModelEntity = newValue {
                print("newSelectedModelEntity, had a prior selection")
                
                previousSelectedModelEntity.modelDebugOptions = nil
                
                let component = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)
                newSelectedModelEntity.modelDebugOptions = component
            } else if newValue == nil {
                print("Clear entitySelectedFromDeletion")
                
                entitySelectedFromDeletion?.modelDebugOptions = nil
            }
        }
    }
}
