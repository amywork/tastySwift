//
//  ProfileDataModel.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 20..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import Foundation

struct ProfileModel {
    
    var nickname:String
    var statusDesc:String
    var profileImageName:String
    
    var email:String
    var phoneNumber:String
    var myProfileDesc:String
    var bgImageName:String
    
    
    init?(data:[String:String])
    {
        guard let nickName = data["Nickname"] else { return nil }
        self.nickname = nickName
        guard let phoneNum = data["PhoneNumber"] else { return nil }
        self.phoneNumber = phoneNum
        guard let proImgName = data["ProfileImage"] else { return nil }
        self.profileImageName = proImgName
        guard let proDesc = data["MyProfileDescription"] else { return nil }
        self.myProfileDesc = proDesc
        guard let bgImgName = data["BackgroundImage"] else { return nil }
        self.bgImageName = bgImgName
        guard let statusDesc = data["StatusDescription"] else { return nil }
        self.statusDesc = statusDesc
        guard let email = data["Email"] else { return nil }
        self.email = email
        
    }
}




