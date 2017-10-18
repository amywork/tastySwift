//
//  User.swift
//  1018_Fanxy
//
//  Created by 김기윤 on 18/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let username: String
    var email: String
    var password: String
}


struct Users: Codable {
    var users: [User]
}
