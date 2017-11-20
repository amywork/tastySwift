//
//  DataModel.swift
//  Onstagram
//
//  Created by Kyuhan Shin on 2017. 11. 20..
//  Copyright © 2017년 Kyuhan Shin. All rights reserved.
//

import Foundation

struct UserModel {
    var email: String
    var uid: String
 
    init(_ email: String, _ uid: String){
        self.email = email
        self.uid = uid
    }
}
