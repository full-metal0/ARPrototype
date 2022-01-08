//
//  ControlButton.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct ControlButton: View {
    
    let systemIcon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Image(systemName: systemIcon)
                .font(.system(size: 35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 50, height: 50)

    }
}

struct ControlButton_Previews: PreviewProvider {
    static var previews: some View {
        ControlButton(systemIcon: "clock.fill", action: { print("Button pressed")})
            .previewLayout(.sizeThatFits)
            .background(.black.opacity(0.25))
    }
}
