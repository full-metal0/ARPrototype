//
//  ARModel.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI
import RealityKit
import Combine

class ARModel {
    
    private var cancellable: AnyCancellable?
    
    var name: String
    var category: ARModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    init(name: String, category: ARModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.scaleCompensation = scaleCompensation
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
    }
    
    func asyncLoadARModelEntity() {
        let fileName = self.name + ".usdz"
        
        cancellable = ModelEntity.loadModelAsync(named: fileName)
            .sink { loadCompletion in
                
                switch loadCompletion {
                case .failure(let error):
                    print("Load error occured for \(fileName) - Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                // check
                self.modelEntity?.scale *= self.scaleCompensation
                print("Entity was loaded")
            }
        
    }
}
