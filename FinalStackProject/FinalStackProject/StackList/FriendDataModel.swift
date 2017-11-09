//
//  FriendDataMode.swift
//  FinalStackProject
//
//  Created by Kimkeeyun on 21/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
struct FriendDataModel {
    
    var nickName: String
    var myProfileDescription: String
    var statusDescription: String
    
    var profileImageName: String
    var bgImageName: String
    
    var phoneNumber: String
    var email: String
    
    var friendDataDic: [String:String] {
        return ["Nickname":self.nickName,
                "MyProfileDescription":self.myProfileDescription,
                "StatusDescription":self.statusDescription,
                "PhoneNumber":self.phoneNumber,
                "Email":self.email,
                "BackgroundImage":self.bgImageName,
                "ProfileImage":self.profileImageName,
        ]
    }
    
    init?(with dataDic: [String:String]) {
        
        guard let name = dataDic["Nickname"] else { return nil }
        self.nickName = name
        
        guard let profileStr = dataDic["MyProfileDescription"] else { return nil }
        self.myProfileDescription = profileStr
        
        guard let statusStr = dataDic["StatusDescription"] else { return nil }
        self.statusDescription = statusStr
        
        guard let phoneStr = dataDic["PhoneNumber"] else { return nil }
        self.phoneNumber = phoneStr
        
        guard let emailStr = dataDic["Email"] else { return nil }
        self.email = emailStr
        
        guard let bgImageStr = dataDic["BackgroundImage"] else { return nil }
        self.bgImageName = bgImageStr
        
        guard let profileImg = dataDic["ProfileImage"] else { return nil }
        self.profileImageName = profileImg
        
    }
    
}
