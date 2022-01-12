//
//  SessionSettings.swift
//  ARPtorotype
//
//  Created by Kaligula on 13.01.2022.
//

import SwiftUI

class SessionSettings: ObservableObject {
    @Published var isPeopleOcclusionEnabled: Bool = false
    @Published var isObjectOcclusionEnabled: Bool = false
    @Published var isMultiUserEnabled: Bool = false
    @Published var isLidarEnabled: Bool = false
}

enum Settings {
    case peopleOcclusion
    case objectOcclusion
    case multiUser
    case lidar
    
    var label: String {
        get {
            switch self {
            case .peopleOcclusion, .objectOcclusion:
                return "Occlusion"
            case .multiUser:
                return "MultiUser"
            case .lidar:
                return "LiDAR"
            }
        }
    }
    
    var systemIconName: String {
        get {
            switch self {
            case .peopleOcclusion:
                return "person"
            case .objectOcclusion:
                return "cube.box.fill"
            case .multiUser:
                return "person.2"
            case .lidar:
                return "light.min"
            }
        }
    }
}
