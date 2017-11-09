//
//  CardCell.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    
    var isStarred: Bool = false
    var data: CardData? {
        didSet {
            self.nameLabel.text = data?.cardName
            if let name = data?.cardImgName {
                self.imgView.image = UIImage(named: name)
            }
            if let data = data?.imgData {
                self.imgView.image = UIImage(data: data)
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func didTapStarBtn(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
