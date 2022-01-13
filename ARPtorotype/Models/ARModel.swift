//
//  ARModel.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI
import RealityKit
import Combine

class ARModel: ObservableObject, Identifiable {
    
    private var cancellable: AnyCancellable?
    
    var id: String = UUID().uuidString
    var name: String
    var category: ARModelCategory
    @Published var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    init(name: String, category: ARModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.scaleCompensation = scaleCompensation
        // TODO: create a load circle
        self.thumbnail = UIImage(systemName: "photo")!
        
        FirebaseStorageHelper.asyncDownloadToFileSystem(relativePath: "thumbnails/\(self.name).png") { fileUrl in
            do {
                let imageData = try Data(contentsOf: fileUrl)
                self.thumbnail = UIImage(data: imageData) ?? self.thumbnail
            } catch {
                print("Error loading image: \(error.localizedDescription)")
            }
        }
    }
    
    func asyncLoadARModelEntity() {
        FirebaseStorageHelper.asyncDownloadToFileSystem(relativePath: "armodels/\(self.name).usdz") { fileUrl in
            self.cancellable = ModelEntity.loadModelAsync(contentsOf: fileUrl)
                .sink { loadCompletion in
                    
                    switch loadCompletion {
                    case .failure(let error):
                        print("Load error occured for \(self.name) - Error: \(error.localizedDescription)")
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
