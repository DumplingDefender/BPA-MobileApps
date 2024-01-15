//
//  BPA_MobileAppsApp.swift
//  BPA-MobileApps
//
//  Created by Krish Bothra on 11/26/23.
//

import SwiftUI
import Firebase

@main
struct BPA_MobileAppsApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
