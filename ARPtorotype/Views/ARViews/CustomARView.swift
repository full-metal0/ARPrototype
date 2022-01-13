//
//  CustomARView.swift
//  ARPtorotype
//
//  Created by Kaligula on 10.01.2022.
//

import RealityKit
import ARKit
import FocusEntity
import SwiftUI
import Combine

class CustomARView: ARView {
    
    // TODO: rewrite FocusEntity to native
    var focusEntity: FocusEntity?
    var sessionSettings: SessionSettings
    
    // TODO: refactor anyCancellable properties into one set
    // settings feature's cancel properties
    private var peopleOcclusionCancellable: AnyCancellable?
    private var objectOcclusionCancellable: AnyCancellable?
    private var multiUserCancellable: AnyCancellable?
    private var lidarCancellable: AnyCancellable?
    
    required init(frame frameRect: CGRect, sessionSettings: SessionSettings) {
        self.sessionSettings = sessionSettings
        
        super.init(frame: frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
        
        configure()
        
        self.initializeSettings()
        
        self.setapSubscribers()
    }
    
    required init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    private func configure() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.vertical, .horizontal]
        
        // check LiDAR
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        session.run(config)
    }
    
    @MainActor @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setapSubscribers() {
        self.peopleOcclusionCancellable = self.sessionSettings.$isPeopleOcclusionEnabled.sink(receiveValue: { [weak self] isEnabled in
            self?.updatePeopleOcclusion(isEnabled: isEnabled)
        })
        
        self.objectOcclusionCancellable = self.sessionSettings.$isObjectOcclusionEnabled.sink(receiveValue: { [weak self] isEnabled in
            self?.updateObjectOcclusion(isEnabled: isEnabled)
        })
        
        self.multiUserCancellable = self.sessionSettings.$isMultiUserEnabled.sink(receiveValue: { [weak self] isEnabled in
            self?.updateMultiUser(isEnabled: isEnabled)
        })
        
        self.lidarCancellable = self.sessionSettings.$isLidarEnabled.sink(receiveValue: { [weak self] isEnabled in
            self?.updatePeopleOcclusion(isEnabled: isEnabled)
        })
    }
    
    private func updatePeopleOcclusion(isEnabled: Bool) {
        print("\(#file): isPeopleOcclusionEnabled is now \(isEnabled)")
        
        // check possibility of people occlusion
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else {
            return
        }
        
        guard let config = self.session.configuration as? ARWorldTrackingConfiguration else {
            return
        }
        
        // on/off people occlusion
        if config.frameSemantics.contains(.personSegmentationWithDepth) {
            config.frameSemantics.remove(.personSegmentationWithDepth)
        } else {
            config.frameSemantics.insert(.personSegmentationWithDepth)
        }
        
        self.session.run(config)
    }
    
    // TODO: Fix
    private func updateObjectOcclusion(isEnabled: Bool) {
        print("\(#file): isObjectOcclusionEnabled is now \(isEnabled)")
        
        if self.environment.sceneUnderstanding.options.contains(.occlusion) {
            self.environment.sceneUnderstanding.options.remove(.occlusion)
        } else {
            self.environment.sceneUnderstanding.options.insert(.occlusion)
        }
    }
    
    private func updateMultiUser(isEnabled: Bool) {
        print("\(#file): isMultiUserEnabled is now \(isEnabled)")
    }
    
    private func updateLidar(isEnabled: Bool) {
        print("\(#file): isLiDAREnabled is now \(isEnabled)")
        
        if self.debugOptions.contains(.showSceneUnderstanding) {
            self.debugOptions.remove(.showSceneUnderstanding)
        } else {
            self.debugOptions.insert(.showSceneUnderstanding)
        }
    }
    
    private func initializeSettings() {
        self.updatePeopleOcclusion(isEnabled: sessionSettings.isPeopleOcclusionEnabled)
        self.updateObjectOcclusion(isEnabled: sessionSettings.isObjectOcclusionEnabled)
        self.updateMultiUser(isEnabled: sessionSettings.isMultiUserEnabled)
        self.updateLidar(isEnabled: sessionSettings.isLidarEnabled)
    }
}
