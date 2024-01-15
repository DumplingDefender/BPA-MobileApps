//
//  LoginView.swift
//  BPA-MobileApps
//
//  Created by Krish Bothra on 11/26/23.
//

import SwiftUI

struct LoginView: View{
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View{
        NavigationStack{
            VStack{
                // image
                Image("BPA-Event-Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width:100, height: 120)
                    .padding(.vertical, 32)
                    
                // form fields
                VStack(spacing:24){
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                        
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //sign in button
                
                Button {
                    Task{
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack{
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top,24)
                
                
                Spacer()
                
                //sign up bottom
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View{
        LoginView()
    }
}
