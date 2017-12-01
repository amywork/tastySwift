//
//  SettingDataModel.swift
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
enum CellType: String {
    case detail = "SettingDetailCell"
    case basic = "SettingBasicCell"
    case withSwitch = "SettingSwitchCell"
    case text = "SettingTextCell"
    case disabled = "SettingDisabledCell"
}

// MARK: - Section of Setting
struct SettingData {
    
    var sectionTitle: String = ""
    var cellContentList: [String] = []
    var cellTypeList: [CellType] = []
    
    init(with dataDic:[String:Any]) {
        
        let sectionTitle = dataDic["SectionTitle"] as? String
        self.sectionTitle = sectionTitle!
        
        guard let dataDicArr = dataDic["Data"] as? [[String:String]] else { return }
        for dataDic in dataDicArr {
            guard let cellTypeStr = dataDic["CellStyle"] else { return }
            let cellType = CellType(rawValue: cellTypeStr) ?? .basic
            self.cellTypeList.append(cellType)
            
            guard let cellContentStr = dataDic["Content"] else { return }
            self.cellContentList.append(cellContentStr)
        }
    }
    
}
