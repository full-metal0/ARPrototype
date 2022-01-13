////
////  ARModelStore.swift
////  ARPtorotype
////
////  Created by Kaligula on 08.01.2022.
////
//
//import Foundation
//
//struct ARModelStore {
//    var models: [ARModel] = []
//
//    init() {
//        let toyCar = ARModel(name: "toy_car", category: .statuette)
//        let toyRobotVintage = ARModel(name: "toy_robot_vintage", category: .statuette)
//        let amogus = ARModel(name: "amogus", category: .statuette)
//
//        let chairBlack = ARModel(name: "chair_black", category: .chair)
//        let chairSwan = ARModel(name: "chair_swan", category: .chair)
//
//        let cupSaucerSet = ARModel(name: "cup_saucer_set", category: .decor)
//        let fenderStratocaster = ARModel(name: "fender_stratocaster", category: .decor)
//
//        self.models += [toyCar, toyRobotVintage, amogus, chairBlack, chairSwan, cupSaucerSet, fenderStratocaster]
//    }
//
//    func get(category: ARModelCategory) -> [ARModel] {
//        return models.filter( { $0.category == category })
//    }
//}
//
//enum ARModelCategory: String, CaseIterable {
//    case chair
//    case decor
//    case statuette
//
//    var label: String {
//        switch self {
//        case .chair:
//            return "Chairs"
//        case .decor:
//            return "Decor"
//        case .statuette:
//            return "Statuettes"
//        }
//    }
//}
