//
//  ContentView.swift
//  BPA-MobileApps
//
//  Created by Krish Bothra on 11/26/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group{
            if viewModel.userSession != nil{
                ProfileView()
            }else{
                LoginView()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
