//
//  SettingTableViewCell.swift
//  1018_Fanxy
//
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var accessoryLabel: UILabel?
    @IBOutlet weak var swithcher: UISwitch?
    
    override func awakeFromNib() {
        self.accessoryLabel?.text = ""
        self.swithcher?.isHidden = true
    }
    
    var index: Int = 0
    var delegate: SettingCellDelegate?
    
    var data: SettingDataModel? {
        didSet {
            let index = self.index
            self.textLabel?.text = data?.cellContentList[index]
            if data?.cellTypeList[index] == CellType.detail {
                self.accessoryType = .disclosureIndicator
            }else if data?.cellTypeList[index] == CellType.withSwitch {
                self.swithcher?.isHidden = false
                self.delegate?.didChangedSwitchValue(self.swithcher!)
            }else if data?.cellTypeList[index] == CellType.basic {
                self.accessoryLabel?.text = ""
            }else if data?.cellTypeList[index] == CellType.text {
                self.accessoryLabel?.text = "1.2.1"
                self.isUserInteractionEnabled = false
            }
        }
    }
    
}


protocol SettingCellDelegate {
    func didChangedSwitchValue(_ sender: UISwitch)
}
