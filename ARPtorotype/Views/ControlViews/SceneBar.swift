//
//  SceneBar.swift
//  ARPtorotype
//
//  Created by Kaligula on 15.01.2022.
//

import SwiftUI
import RealityKit

struct SceneBar: View {
    @EnvironmentObject var sceneManager: SceneManager
    
    var body: some View {
        ControlButton(systemIcon: "icloud.and.arrow.up") {
            sceneManager.shouldSaveSceneToFilesystem = true
        }
        .hide(!self.sceneManager.isPersistenceAvailable)
        
        Spacer()
        
        ControlButton(systemIcon: "icloud.and.arrow.down") {
            sceneManager.shouldLoadSceneFromFilesystem = true
        }
        .hide(self.sceneManager.scenePersistenceData == nil)
        
        Spacer()
        
        ControlButton(systemIcon: "trash") {
            for anchorEntity in sceneManager.anchorEntities {
                anchorEntity.removeFromParent()
            }
        }
    }
}

struct SceneBar_Previews: PreviewProvider {
    static var previews: some View {
        SceneBar()
    }
}
