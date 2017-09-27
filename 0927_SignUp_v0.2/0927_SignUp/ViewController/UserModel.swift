//
//  UserModel.swift
//  0927_SignUp
//
//  Created by 김기윤 on 27/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  상속 불가한 클래스 : final

import Foundation
final class UserModel {
    
    struct User {
        var username: String
        var password: String
    }
    
    var model: [User] = [
       User(username: "zico", password: "1234"),
       User(username: "dean", password: "5678"),
       User(username: "penomeco", password: "0101")
    ]
    
    // hasUser 검사 method
    func hasUser(name: String, pwd: String) -> Bool {
        for user in model {
            if user.username == name && user.password == pwd {
                return true
            }
        }
        return false
    }
        
    // newUser 추가 method
    func addUser(name: String, pwd: String) {
        let newUser = User(username: name, password: pwd)
        model.append(newUser)
    }

}


