//
//  SearchResultsCell.swift
//  FinalStackProject
//
//  Created by Kimkeeyun on 02/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class SearchResultsCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    
    var data: ExploreDataModel? {
        didSet {
            configureCell()
        }
    }
    
    func configureCell() {
        if let image = data?.iconImage {
            self.iconImageView.image = UIImage(named: image)
        }
        self.titleLabel.text = data?.itemName
        self.subTitleLabel.text = data?.category
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
