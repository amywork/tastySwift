//
//  CustomCollectionViewCell.swift
//  1026_UIGestureProject
//
//  Created by 김기윤 on 27/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    var data: String = "" {
        didSet {
            self.wordLabel.text = data
        }
    }
   
    override var isSelected: Bool {
        willSet {
            if isSelected {
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.borderWidth = 5
            }else {
                self.layer.borderColor = nil
                self.layer.borderWidth = 0
            }
        }
    }
    
}
