//
//  CustomCell.swift
//  1019_Setting
//
//  Created by 김기윤 on 19/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var leftIcon: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    var cellDelegate:CustomCellDelegate?
    var nameOfIndexPath:String?
    
    override func awakeFromNib() {
        leftIcon.layer.cornerRadius = 10
    }
    
    @IBAction func removeBtnHandler(_ sender: UIButton) {
        guard let name = self.nameOfIndexPath else { return }
        DataCenter.mainCenter.removeName(name)
        cellDelegate?.reloadTableView()
    }

}

protocol CustomCellDelegate {
    func reloadTableView()
}
