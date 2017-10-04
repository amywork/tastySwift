//
//  DateTableViewCell.swift
//  1003_DailyTable
//
//  Created by Kimkeeyun on 03/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    // SB의 Prototype cells에 custom으로 만들고 identifier 입력
    @IBOutlet weak var colorBlock: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
