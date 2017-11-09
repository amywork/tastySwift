//
//  StackItemCell.swift
//  FinalStackProject
//
//  Created by 김기윤 on 07/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class StackItemCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLB: UILabel!
    @IBOutlet weak var itemDetailLB: UILabel!
    @IBAction func didTapAddBtn(_ sender: UIButton) {
        
    }
//    
//    var data: ExploreDataModel? {
//        didSet {
//            self.itemImageView.image = UIImage(named: data.iconImage)
//            self.itemTitleLB.text = data.itemName
//            self.itemDetailLB.text = data.category
//        }
//    }
}
