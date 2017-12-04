//
//  ProfileDataManager.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 20..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import Foundation
class ProfileDataManager
{
    
    private var profiles:[ProfileModel] = []
    var profilesData:[ProfileModel]{
        return profiles
    }
    
    
    init() {
        loadData()
    }
    
    func loadData()
    {
        
        //번들에서 데이터 가져와서 profiles만들기
        if let filePath = Bundle.main.path(forResource: "FreindInfo", ofType: "plist"),
            let dataList = NSArray(contentsOfFile:filePath) as? [Any]
        {
            for data in dataList
            {
                if let realData = data as? [String:String],
                    let dataModel = ProfileModel(data: realData)
                {
                    profiles.append(dataModel)
                }
            }
        }
        
    }
}







