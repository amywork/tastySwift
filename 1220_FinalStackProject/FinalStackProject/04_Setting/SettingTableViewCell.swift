//
//  SettingTableViewCell.swift
//  1018_Fanxy
//
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class SettingTableViewCell: UITableViewCell {

    // MARK: - Cell from Storyboard
    @IBOutlet weak var accessoryLabel: UILabel?
    @IBOutlet weak var swithcher: UISwitch?
    
    override func awakeFromNib() {
        self.accessoryLabel?.text = ""
        self.swithcher?.isHidden = true
    }
    
    // MARK: - Cell property
    var index: Int = 0
    var delegate: SettingCellDelegate?
    var data: SettingData? {
        didSet {
            updateUI()
        }
    }
}

/*Extension: Update cell UI from cell data*/
extension SettingTableViewCell {
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
            self.selectionStyle = .none
        case .basic:
            self.accessoryLabel?.text = ""
        case .text:
            let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Invalid Version"
            self.accessoryLabel?.text = version
            self.selectionStyle = .none
        case .disabled:
            self.textLabel?.textColor = UIColor.gray
        }
    }
}

/*Extension: Subscript cell menu type*/
enum CellMenuType {
    case infoMenu // (0,0)
    case changePW // (0,1)
    case logout // (0,2)
    case memberout // (0,3)
    case non
}

extension SettingTableViewCell {
    subscript (section: Int, row: Int) -> CellMenuType {
        if section == 0 {
            if row == 0 {
                return CellMenuType.infoMenu
            }else if row == 1 {
                return CellMenuType.changePW
            }else if row == 2 {
                return CellMenuType.logout
            }else if row == 3 {
                return CellMenuType.memberout
            }
        }
        return CellMenuType.non
    }
}

/*Extension: Cell Delegate Protocol*/
protocol SettingCellDelegate {
    func didChangedSwitchValue(_ sender: UISwitch)
}
