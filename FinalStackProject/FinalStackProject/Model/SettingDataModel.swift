//
//  SettingDataModel.swift
//  1018_Fanxy
//
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
enum CellType {
    case detail
    case basic
    case withSwitch
}

struct SettingDataModel {
    
    var sectionTitle: String = ""

    // Cell Information
    var cellContentList: [String] = []
    var cellTypeList: [CellType] = []
    
    init(with dataDic:[String:Any]) {
        
        let sectionTitle = dataDic["SectionTitle"] as? String
        self.sectionTitle = sectionTitle!
        
        let dataDicArr = dataDic["Data"] as? [[String:String]]
        for dataDic in dataDicArr! {
            let cellStyleStr = dataDic["CellStyle"]
            if cellStyleStr == "SettingDetailCell" {
                self.cellTypeList.append(.detail)
            }else if cellStyleStr == "SettingBasicCell" {
                 self.cellTypeList.append(.basic)
            }else if cellStyleStr == "SettingSwitchCell" {
                self.cellTypeList.append(.withSwitch)
            }
            let cellContentStr = dataDic["Content"]
            self.cellContentList.append(cellContentStr!)
        }
    }
    
}
