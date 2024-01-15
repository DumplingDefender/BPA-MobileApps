//
//  SettingsRowView.swift
//  BPA-MobileApps
//
//  Created by Krish Bothra on 12/30/23.
//



import SwiftUI

struct SettingsRowView: View{
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View{
        HStack(spacing: 12){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(tintColor)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View{
        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
    }
}
