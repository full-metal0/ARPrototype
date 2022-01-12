//
//  MostRecentlyPlacedButton.swift
//  ARPtorotype
//
//  Created by Kaligula on 12.01.2022.
//

import SwiftUI

struct MostRecentlyPlacedButton: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        Button(action: {
            // set most recently ar model
            self.placementSettings.selectedModel = self.placementSettings.recentlyPlaced.last
        }) {
            if let mostRecentlyPlacedModel = self.placementSettings.recentlyPlaced.last {
                Image(uiImage: mostRecentlyPlacedModel.thumbnail)
                    .resizable()
                    .frame(width: 46)
                    .aspectRatio(1/1, contentMode: .fit)
                    .background(Color.black
                                    .opacity(0.25))
            } else {
                Image(systemName: "clock.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(width: 50, height: 50)
        .cornerRadius(8)
    }
}

struct MostRecentlyPlacedButton_Previews: PreviewProvider {
    static var previews: some View {
        MostRecentlyPlacedButton()
            .environmentObject(PlacementSettings())
    }
}
