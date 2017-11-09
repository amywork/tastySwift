//
//  UserModel.swift
//  1016_DataModel
//
//  Created by 김기윤 on 16/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//  Data를 담는 애들은 Struct : Int, Double, Array, Dictionary 등
//  담은 Data를 활용하는 애들은 Class : 주로 UI와 관련된 UIView, CGRect 등

import Foundation
struct UserModel {
    
    enum Gender: Int {
        case women = 1
        case men = 2
    }
    
    var userID: String
    var userPWD: String
    var email: String
    var birthday: String
    var profileImageData: Data?
    var gender: Gender?
    var dictionary:[String:Any] {
        let genderValue = self.gender?.rawValue ?? 0
        let dic:[String:Any] = ["userID":self.userID, "userPWD":self.userPWD, "email":self.email, "gender":genderValue]
        return dic
    }
    
    init?(userDic:[String:Any]) {
        
        // Required Properties
        guard let userID = userDic["userID"] as? String else { return nil }
        self.userID = userID
        
        guard let userPWD = userDic["userPWD"] as? String else { return nil }
        self.userPWD = userPWD
        
        guard let email = userDic["email"] as? String else { return nil }
        self.email = email
        
        guard let birthday = userDic["birthday"] as? String else { return nil }
        self.birthday = birthday
        
        // Optional Properties
        if let gender = userDic["gender"] as? Int, (gender == 1 || gender == 2)
        {
            self.gender = Gender(rawValue: gender)
        }
        
    }
    
}

