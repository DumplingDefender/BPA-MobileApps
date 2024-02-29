//
//  ProfileView.swift
//  BPA-    Apps
//
//  Created by Krish Bothra on 12/27/23.
//

import SwiftUI

struct ProfileView: View{
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View{
        if let user = viewModel.currentUser {
            NavigationStack{
                List {
                    Section{
                        HStack{
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height:72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4){
                                Text(user.fullname)
                                    .fontWeight(.semibold)
                                    .padding(.top,4)
                                Text(user.email)
                                    .font(.footnote)
                                //                            .accentColor(.gray)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        
                    }
                    Section("General"){
                        HStack{
                            SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                            Spacer()
                            Text("1.0.0")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        
                    }
                    
                    Section("Account"){
                        Button{
                            viewModel.signOut()
                        } label: {
                            SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.red))
                        }
                        NavigationLink{
                           EventFormView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            HStack(spacing: 12){
                                Text("Create Event")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider{
    static var previews: some View{
        ProfileView()
    }
}
