//
//  ARModelAnchor.swift
//  ARPtorotype
//
//  Created by Kaligula on 16.01.2022.
//

import SwiftUI
import ARKit

// used for placement, ar anchor will be generated using a raycast 
struct ARModelAnchor {
    var model: ARModel
    var anchor: ARAnchor?
}
