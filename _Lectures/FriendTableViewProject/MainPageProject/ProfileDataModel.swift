//
//  ProfileDataModel.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 20..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import Foundation
/*
 <key>PhoneNumber</key>
 <string>010-1234-5678</string>
 <key>ProfileImage</key>
 <string>ProfileImage1</string>
 <key>MyProfileDescription</key>
 <string>프로듀스 101의 피지컬 甲 진중함과 코믹함, 카리스마와 귀여움이 공존하는 프리스틴의 리더 그리고 영원히 기억될 I.O.I의 리더</string>
 <key>Account</key>
 <string>user1</string>
 <key>Password</key>
 <string>user1</string>
 <key>BackgroundImage</key>
 <string>BackImage1</string>
 <key>StatusDescription</key>
 <string>다이어트중</string>
 <key>Nickname</key>
 <string>강미나</string>
 <key>Email</key>
 <string>mnkang123@fastcampus.co.kr</string>
 <key>LikeCount</key>
 <string></string>
 */
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




