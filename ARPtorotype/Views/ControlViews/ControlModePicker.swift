//
//  ControlModePicker.swift
//  ARPtorotype
//
//  Created by Kaligula on 15.01.2022.
//

import SwiftUI

struct ControlModePicker: View {
    @Binding var selectedControlMode: Int
    // array with all conrol mode cases
    let controlModes = ControlModes.allCases
    
    // TODO: Research
    init(selectedControlMode: Binding<Int>) {
        self._selectedControlMode = selectedControlMode
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .clear
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.purple)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.black.opacity(0.25))
    }
    var body: some View {
        Picker(selection: $selectedControlMode, label: Text("Select a control mode")) {
            ForEach(0..<controlModes.count) { index in
                Text(controlModes[index].rawValue.uppercased())
                    .tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(maxWidth: 400)
        .padding(.horizontal, 10)
    }
}

struct ControlModePicker_Previews: PreviewProvider {
    static var previews: some View {
        ControlModePicker(selectedControlMode: Binding.constant(0))
    }
}
