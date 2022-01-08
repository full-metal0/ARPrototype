//
//  ControlView.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct ControlView: View {
    var body: some View {
        VStack {
            ControlVisibilityToggleButton()
            
            Spacer()
            
            ControlButtonBar()
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
            .edgesIgnoringSafeArea(.all)
    }
}
