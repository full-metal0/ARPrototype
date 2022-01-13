//
//  ItemButton.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct ItemButton: View {
    @ObservedObject var model: ARModel
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Image(uiImage: self.model.thumbnail)
                .resizable()
                .frame(height: 150)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color(UIColor.secondarySystemFill))
                .cornerRadius(8)
        }
    }
}
