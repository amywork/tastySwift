//
//  CardCell.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

protocol CardCellDelegate {
    func didSelectedCell(_ cell: CustomCardCell)
}

class CustomCardCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    
    var delegate: CardCellDelegate?
    var data: CardData? {
        willSet {
            if let newValue = newValue {
                nameLabel.text = newValue.cardName
                imgView.image = newValue.image
                likeBtn.isSelected = newValue.isSelected
            }
        }
    }
    
    @IBAction func didTapLikeBtn(_ sender: UIButton) {
        delegate?.didSelectedCell(self)
    }

}
