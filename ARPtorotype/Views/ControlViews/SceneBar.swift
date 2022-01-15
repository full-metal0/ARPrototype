//
//  SceneBar.swift
//  ARPtorotype
//
//  Created by Kaligula on 15.01.2022.
//

import SwiftUI

struct SceneBar: View {
    @EnvironmentObject var sceneManager: SceneManager
    
    var body: some View {
        ControlButton(systemIcon: "icloud.and.arrow.up") {
            
        }
        .hide(!self.sceneManager.isPersistenceAvailable)
        
        Spacer()
        
        ControlButton(systemIcon: "icloud.and.arrow.down") {
            
        }
        .hide(self.sceneManager.scenePersistenceData == nil)
        
        Spacer()
        
        ControlButton(systemIcon: "trash") {
            
        }
    }
}

struct SceneBar_Previews: PreviewProvider {
    static var previews: some View {
        SceneBar()
    }
}
