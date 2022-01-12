//
//  RecentsGrid.swift
//  ARPtorotype
//
//  Created by Kaligula on 12.01.2022.
//

import SwiftUI

struct RecentsGrid: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    
    var body: some View {
        if !self.placementSettings.recentlyPlaced.isEmpty {
            HorizontalGrid(showBrowse: $showBrowse, title: "Recents", items: getRecentsUniqueOrdered())
        }
    }
    
    // TODO: refactor method
    func getRecentsUniqueOrdered() -> [ARModel] {
        var recentsUniqueOrderedArray: [ARModel] = []
        var arModelNameSet: Set<String> = []
        
        for model in self.placementSettings.recentlyPlaced.reversed() {
            if !arModelNameSet.contains(model.name) {
                recentsUniqueOrderedArray.append(model)
                arModelNameSet.insert(model.name)
            }
        }
        
        return recentsUniqueOrderedArray
    }
}

struct RecentsGrid_Previews: PreviewProvider {
    static var previews: some View {
        RecentsGrid(showBrowse: Binding.constant(true))
            .environmentObject(PlacementSettings())
    }
}
