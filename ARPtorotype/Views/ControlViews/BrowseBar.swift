//
//  BrowseBar.swift
//  ARPtorotype
//
//  Created by Kaligula on 15.01.2022.
//

import SwiftUI

struct BrowseBar: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
    
    var body: some View {
        HStack {
            MostRecentlyPlacedButton().hide(self.placementSettings.recentlyPlaced.isEmpty)

            Spacer()
            
            ControlButton(systemIcon: "square.grid.2x2") {
                self.showBrowse.toggle()
            }.sheet(isPresented: $showBrowse) {
                BrowseView(showBrowse: $showBrowse)
                    .environmentObject(placementSettings)
            }
            
            Spacer()
            
            ControlButton(systemIcon: "slider.horizontal.3") {
                self.showSettings.toggle()
            }.sheet(isPresented: $showSettings) {
                SettingsView(showSettings: $showSettings)
            }

        }
    }
}

struct BrowseBar_Previews: PreviewProvider {
    static var previews: some View {
        BrowseBar(showBrowse: .constant(true), showSettings: .constant(false))
    }
}
