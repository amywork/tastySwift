//
//  FriendDataModel.swift
//  1020_FriendTableView
//
//  Created by 김기윤 on 19/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

struct FriendDataModel {
    
    var Nickname: String
    var MyProfileDescription: String
    var ProfileImage: String?
    var friendDataDic: [String:String] {
        return ["Nickname":self.Nickname, "MyProfileDescription":self.MyProfileDescription]
    }
    
    init?(with dataDic: [String:Any]) {
        
        guard let name = dataDic["Nickname"] as? String else { return nil }
        self.Nickname = name
        
        guard let profileStr = dataDic["MyProfileDescription"] as? String else { return nil }
        self.MyProfileDescription = profileStr
        
        if let img = dataDic["ProfileImage"] as? String {
            self.ProfileImage = img
        }
        
    }

}
