//
//  ARModelsViewModel.swift
//  ARPtorotype
//
//  Created by Kaligula on 13.01.2022.
//

import Foundation
import FirebaseFirestore

class ARModelsViewModel: ObservableObject {
    @Published var arModels: [ARModel] = []
    
    private let db = Firestore.firestore()
    
    func fetchData() {
        db.collection("armodels").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Firestore: Failed - No documents")
                return
            }
            
            self.arModels = documents.map { queryDocumentSnapshot -> ARModel in
                let data = queryDocumentSnapshot.data()
                
                let name = data["name"] as? String ?? ""
                let categoryName = data["category"] as? String ?? ""
                let category = ARModelCategory(rawValue: categoryName) ?? .decor
                let scaleCompensation = data["scaleCompensation"] as? Double ?? 1.0 // Firestore returns Double type
                
                return ARModel(name: name, category: category, scaleCompensation: Float(scaleCompensation))
            }
        }
    }
    
    func clearARModelEntitiesFromMemory() {
        for model in arModels {
            model.modelEntity = nil
        }
    }
}
