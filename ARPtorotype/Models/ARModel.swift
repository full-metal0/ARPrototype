//
//  ARModel.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI
import RealityKit
import Combine

class ARModel: Identifiable {
    
    private var cancellable: AnyCancellable?
    
    var id: String = UUID().uuidString
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
                // TODO: check possibility 
                self.modelEntity?.scale *= self.scaleCompensation
                print("Entity was loaded")
            }
        
    }
}

enum ARModelCategory: String, CaseIterable {
    case chair
    case decor
    case statuette
    
    var label: String {
        switch self {
        case .chair:
            return "Chairs"
        case .decor:
            return "Decor"
        case .statuette:
            return "Statuettes"
        }
    }
}
