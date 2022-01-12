//
//  SettingsGrid.swift
//  ARPtorotype
//
//  Created by Kaligula on 13.01.2022.
//

import SwiftUI

struct SettingsGrid: View {
    @EnvironmentObject var sessionSettings: SessionSettings
    private var gridItemLayout = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 25)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 25) {
                SettingsButton(settings: .peopleOcclusion, isOn: $sessionSettings.isPeopleOcclusionEnabled)
                
                SettingsButton(settings: .objectOcclusion, isOn: $sessionSettings.isObjectOcclusionEnabled)
                
                SettingsButton(settings: .peopleOcclusion, isOn: $sessionSettings.isMultiUserEnabled)
                
                SettingsButton(settings: .peopleOcclusion, isOn: $sessionSettings.isLidarEnabled)
            }
        }
        .padding(.top, 35)
    }
}

struct SettingsGrid_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGrid()
    }
}
