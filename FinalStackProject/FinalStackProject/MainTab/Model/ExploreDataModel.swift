//
//  ExploreDataModel.swift
//  FinalStackProject
//
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//
import Foundation
struct ExploreDataModel {
    
    var itemName: String
    var iconImage: String
    var URL: String
    var followerCnt: String
    var category: String
 
    var exploreDataDic: [String:String] {
        return ["itemName":self.itemName,
                "iconImage":self.iconImage,
                "URL":self.URL,
                "followerCnt":self.followerCnt,
                "category":self.category
        ]
    }
    
    init?(with dataDic: [String:String]) {
        guard let name = dataDic["itemName"] else { return nil }
        self.itemName = name
        
        guard let img = dataDic["iconImage"] else { return nil }
        self.iconImage = img
        
        guard let url = dataDic["URL"] else { return nil }
        self.URL = url
        
        guard let follower = dataDic["followerCnt"] else { return nil }
        self.followerCnt = follower
        
        guard let category = dataDic["category"] else { return nil }
        self.category = category
    }
    
}

