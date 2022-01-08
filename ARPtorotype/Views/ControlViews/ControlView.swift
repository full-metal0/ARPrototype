//
//  ControlView.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct ControlView: View {
    
    @Binding var isControlVisible: Bool
    
    var body: some View {
        VStack {
            ControlVisibilityToggleButton(isControlVisible: $isControlVisible)
            
            Spacer()
            
            if isControlVisible {
                ControlButtonBar()
            }
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var isControlVisible: Bool = true
    
    static var previews: some View {
        ControlView(isControlVisible: Binding.constant(true))
            .edgesIgnoringSafeArea(.all)
    }
}
