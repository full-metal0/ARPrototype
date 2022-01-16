//
//  DeletionView.swift
//  ARPtorotype
//
//  Created by Kaligula on 16.01.2022.
//

import SwiftUI

struct DeletionView: View {
    @EnvironmentObject var sceneManager: SceneManager
    @EnvironmentObject var arModelDeletionManager: ARModelDeletionManager
    
    var body: some View {
        HStack {
            Spacer()
            
            DeletionButton(systemIconName: "xmark.circle.fill") {
                arModelDeletionManager.entitySelectedFromDeletion = nil
            }
            
            Spacer()
            
            DeletionButton(systemIconName: "trash.circle.fill") {
                guard let anchor = arModelDeletionManager.entitySelectedFromDeletion?.anchor else {
                    return
                }
                
                let anchorId = anchor.anchorIdentifier
                // not ellegant, will be problems with large array
                if let index = sceneManager.anchorEntities.firstIndex(where: { $0.anchorIdentifier == anchorId }) {
                    sceneManager.anchorEntities.remove(at: index)
                }
                
                anchor.removeFromParent()
                
                arModelDeletionManager.entitySelectedFromDeletion = nil
            }
            
            Spacer()
        }
        .padding(.bottom, 30)
    }
}

struct DeletionView_Previews: PreviewProvider {
    static var previews: some View {
        DeletionView()
    }
}
