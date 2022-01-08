//
//  ContentView.swift
//  ARPtorotype
//
//  Created by Kaligula on 06.01.2022.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    @State private var isControlVisible: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            ControlView(isControlVisible: $isControlVisible)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
