//
//  AuthViewModel.swift
//  BPA-MobileApps
//
//  Created by Krish Bothra on 12/30/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentSession: User?
    
    init() {
        
    }
    
    func signIn(withEmail email: String , password: String) async throws {
        print("Sign in...")
    }
    
    func createUser(withEmail email: String , password: String, fullname: String) async throws {
        do{
            let result =  try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)  
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch{
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    func signOut(){
        
    }
    
    func deleteAccount(){
        
    }
    
    func fetchUser() async{
        
    }
    
}
