//
//  CustomARView.swift
//  ARPtorotype
//
//  Created by Kaligula on 10.01.2022.
//

import RealityKit
import ARKit
import FocusEntity

class CustomARView: ARView {
    
    // TODO: rewrite FocusEntity to native
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
        
        configure()
    }
    
    private func configure() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.vertical, .horizontal]
        session.run(config)
    }
    
    @MainActor @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
