//
//  ViewExtension.swift
//  ARPtorotype
//
//  Created by Kaligula on 12.01.2022.
//

import SwiftUI

extension View {
    @ViewBuilder func hide(_ mustHide: Bool) -> some View {
        if mustHide {
            self.hidden()
        } else {
            self
        }
    }
}
