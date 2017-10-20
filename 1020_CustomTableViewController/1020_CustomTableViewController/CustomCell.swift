//
//  CustomCell.swift
//  1020_CustomTableViewController
//
//  Created by 김기윤 on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class CustomCell: UITableViewCell {
    
    @IBOutlet var switcher: UISwitch!
    
    var cellDelegate:CustomCellDelegate?
    var indexPath:IndexPath?
    var switchData:Bool = true {
        willSet {
            self.switcher.isOn = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func switchBtnHandler(_ sender: UISwitch) {
        cellDelegate?.customCellSwitched(self, didChangedSwitch: sender.isOn)
    }

}

protocol CustomCellDelegate {
    func customCellSwitched(_ cell:CustomCell, didChangedSwitch value:Bool)
}
