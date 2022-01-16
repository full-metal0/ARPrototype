//
//  ControlButtonBar.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct ControlButtonBar: View {
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
    var selectedControlMode: Int // only reads, so without @Binding
    
    var body: some View {
        HStack(alignment: .center) {
            if selectedControlMode == 1 {
                SceneBar()
            }
            else {
                BrowseBar(showBrowse: $showBrowse, showSettings: $showSettings)
            }
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(.black.opacity(0.25))
    }

}

struct ControlButtonBar_Previews: PreviewProvider {
    static var previews: some View {
        ControlButtonBar(showBrowse: Binding.constant(false), showSettings: Binding.constant(false), selectedControlMode: 0)
            .previewLayout(.sizeThatFits)
    }
}
