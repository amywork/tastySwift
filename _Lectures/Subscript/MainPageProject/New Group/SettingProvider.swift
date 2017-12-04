//
//  SettingProvider.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 24..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import Foundation



struct SecctionDataModel
{
    var sectionTitle:String
    var rows:[CellDataModel] = []
    var rowCount:Int{
        return self.rows.count
    }
    
    init(data:[String:Any])
    {
        sectionTitle = data["SectionTitle"] as? String ?? ""
        if let list = data["Data"] as? [[String:String]]
        {
            for data in list
            {
                if let model = CellDataModel(data: data)
                {
                    rows.append(model)
                }
            }
        }else
        {
            return
        }
    }
    
}

struct CellDataModel
{
    var style:CellType
    var cellTitle:String
    
    init?(data:[String:String])
    {
        guard let styleID = data["CellStyle"] else {
            return nil
        }
        self.style = CellType(rawValue: styleID) ?? .baseType
        
        guard let title = data["Content"] else {
            return nil
        }
        self.cellTitle = title
    }
    
    
    
}

enum CellType:String
{
    case baseType = "SettingBasicCell"
    case detailType = "SettingDetailCell"
    case switchType = "SettingSwitchCell"
    case buttonType = "SettingButtonCell"
}




class SettingProvider
{
    var settingData:[SecctionDataModel] = []
    
    init() {
        load()
    }
    
    func load()
    {
        guard let path = Bundle.main.path(forResource: "Settings", ofType: "plist") else {return}
        if let list = NSArray(contentsOfFile:path) as? [[String:Any]]
        {
            for data in list
            {
                settingData.append(SecctionDataModel(data: data))
            }
        }
    }
}
