//
//  ARModel.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI
import RealityKit
import Combine

enum ARModelCategory: CaseIterable {
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

class ARModel {
    
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
}
