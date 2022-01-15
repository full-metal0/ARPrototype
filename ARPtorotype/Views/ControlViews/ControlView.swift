//
//  ControlView.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct ControlView: View {
    @Binding var selectedControlMode: Int
    @Binding var isControlVisible: Bool
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
    
    var body: some View {
        VStack {
            ControlVisibilityToggleButton(isControlVisible: $isControlVisible)
            
            Spacer()
            
            if isControlVisible {
                ControlModePicker(selectedControlMode: $selectedControlMode)
                ControlButtonBar(showBrowse: $showBrowse, showSettings: $showSettings, selectedControlMode: selectedControlMode)
            }
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var isControlVisible: Bool = true
    
    static var previews: some View {
        ControlView(selectedControlMode: Binding.constant(0), isControlVisible: Binding.constant(true), showBrowse: Binding.constant(false), showSettings: Binding.constant(false))
            .edgesIgnoringSafeArea(.all)
    }
}

// enum collection
enum ControlModes: String, CaseIterable {
    case browse
    case scene
}
