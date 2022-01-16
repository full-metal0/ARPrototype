//
//  ARPrototypeAP.swift
//  ARPtorotype
//
//  Created by Kaligula on 10.01.2022.
//

import SwiftUI
import Firebase

@main
struct ARPrototypeAP: App {
    @StateObject var placementSettings = PlacementSettings()
    @StateObject var sessionSettings = SessionSettings()
    @StateObject var sceneManager = SceneManager()
    @StateObject var arModelsViewModel = ARModelsViewModel()
    @StateObject var arModelDeletionManager = ARModelDeletionManager()
    
    init() {
        FirebaseApp.configure()
        
        // Anonymous authentification with Firebase
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else {
                print("Firebase: Falied user Anonymous authentification")
                return
            }
            
            let uid = user.uid
            print("Firebase: Anonymous user authentification with uid - \(uid)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
                .environmentObject(sessionSettings)
                .environmentObject(sceneManager)
                .environmentObject(arModelsViewModel)
                .environmentObject(arModelDeletionManager)
        }
    }
}

