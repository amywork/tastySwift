//
//  CustomCardCell.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class CustomCardCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var data: CardData? {
        willSet {
            if let newValue = newValue {
                nameLabel.text = newValue.name
                imgView.image = newValue.image
            }
        }
    }
    
}

