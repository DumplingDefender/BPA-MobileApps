//
//  User.swift
//  BPA-MobileApps
//
//  Created by Krish Bothra on 12/30/23.
//

import Foundation

struct User: Identifiable, Codable{
    let id: String
    let fullname: String
    let email: String
    
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
        //return an image or sum
    }
}

extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "James Harden", email: "test@gmail.com")
}
