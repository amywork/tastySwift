//
//  SettingTableViewCell.swift
//  1018_Fanxy
//
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class SettingTableViewCell: UITableViewCell {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    var index: Int = 0
    var data: SettingDataModel? {
        didSet {
            let index = self.index
            self.textLabel?.text = data?.cellContentList[index]
            if data?.cellTypeList[index] == CellType.detail {
                self.accessoryType = .disclosureIndicator
            }else if data?.cellTypeList[index] == CellType.withSwitch {
                self.accessoryType = .checkmark
            }
        }
    }
    
}
