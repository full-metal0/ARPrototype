//
//  ContentView.swift
//  ARPtorotype
//
//  Created by Kaligula on 06.01.2022.
//

import SwiftUI

struct ContentView : View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @EnvironmentObject var sessionSettings: SessionSettings
    @EnvironmentObject var arModelsViewModel: ARModelsViewModel
    @EnvironmentObject var arModelDeletionManager: ARModelDeletionManager
    @State private var isControlVisible: Bool = true
    @State private var showBrowse: Bool = false
    @State private var showSettings: Bool = false
    @State private var selectedControlMode: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            if placementSettings.selectedModel != nil {
                PlacementView()
            } else if arModelDeletionManager.entitySelectedFromDeletion != nil {
                DeletionView()
            } else {
                ControlView(selectedControlMode: $selectedControlMode, isControlVisible: $isControlVisible, showBrowse: $showBrowse, showSettings: $showSettings)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            arModelsViewModel.fetchData()
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PlacementSettings())
            .environmentObject(SessionSettings())
            .environmentObject(SceneManager())
            .environmentObject(ARModelsViewModel())
            .preferredColorScheme(.dark)
    }
}
#endif
