//
//  SettingsView.swift
//  ARPtorotype
//
//  Created by Kaligula on 13.01.2022.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    
    var body: some View {
        NavigationView {
            SettingsGrid()
                .navigationBarTitle(Text("Settings"), displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.showSettings.toggle()
                }) {
                    // TODO: Refactor text to image
                    Text("Done").bold()
                })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettings: Binding.constant(true))
    }
}
