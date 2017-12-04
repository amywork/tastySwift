//
//  User.swift
//  Onstagram
//
//  Created by Kimkeeyun on 03/12/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation

struct User {
    
    let uid: String
    let email: String
    var profileImageUrl: String?
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }

    mutating func addProfileImage(dictionary: [String: Any]) {
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}

