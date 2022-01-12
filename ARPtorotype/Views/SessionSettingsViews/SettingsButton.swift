//
//  SettingsButton.swift
//  ARPtorotype
//
//  Created by Kaligula on 13.01.2022.
//

import SwiftUI

struct SettingsButton: View {
    let settings: Settings
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
            print("\(#file) - \(settings) : \(self.isOn)")
        }) {
            VStack {
                Image(systemName: settings.systemIconName)
                    .font(.system(size: 35))
                    .foregroundColor(self.isOn ? .purple : Color(UIColor.secondaryLabel))
                    .buttonStyle(PlainButtonStyle())
                
                Text(settings.label)
                    .font(.system(size: 17, weight: .medium, design: .default))
                    .foregroundColor(self.isOn ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                    .padding(.top, 5)
            }
        }
        .frame(width: 100, height: 100)
        .background(Color(UIColor.secondarySystemFill))
        .cornerRadius(20)
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(settings: .peopleOcclusion, isOn: Binding.constant(true))
    }
}
