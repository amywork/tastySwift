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
            updateUI()
        }
    }
    
    func updateUI() {
        let index = self.index
        self.textLabel?.text = data?.cellContentList[index]
        guard let cellType = data?.cellTypeList[index] else { return }
        switch cellType {
        case .detail:
            self.accessoryType = .disclosureIndicator
        case .withSwitch:
            self.swithcher?.isHidden = false
            self.delegate?.didChangedSwitchValue(self.swithcher!)
        case .basic:
            self.accessoryLabel?.text = ""
        case .text:
            let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
            self.accessoryLabel?.text = version
            self.isUserInteractionEnabled = false
        }
    }
}


protocol SettingCellDelegate {
    func didChangedSwitchValue(_ sender: UISwitch)
}
