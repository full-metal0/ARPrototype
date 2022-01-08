//
//  ControlVisibilityToggleButton.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct ControlVisibilityToggleButton: View {
    
    @Binding var isControlVisible: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack {
                Color.black.opacity(0.25)
                
                Button(action: {
                    self.isControlVisible.toggle()
                }) {
                    Image(systemName: self.isControlVisible ? "rectangle" : "slider.horizontal.below.rectangle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
    }
}

struct ControlVisibilityToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        ControlVisibilityToggleButton(isControlVisible: Binding.constant(true))
            .previewLayout(.sizeThatFits)
    }
}
