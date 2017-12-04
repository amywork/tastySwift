//
//  PhotoTableViewCell.swift
//  WPhotoWitget
//
//  Created by youngmin joo on 2017. 11. 9..
//  Copyright © 2017년 youngmin joo. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet var bgImgView:UIImageView!
    @IBOutlet var titleLb:UILabel!
    @IBOutlet var likeBtn:UIButton!
    
    var delegate:PhotoTableViewCellDelegate?
    
    var cellData:PhotoData?{
        willSet{
            titleLb.text = newValue!.title
            bgImgView.image = newValue!.image
            likeBtn.isSelected = newValue!.isLike
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgImgView.contentMode = .scaleAspectFill
        bgImgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectedLikeHandler(_ sender:UIButton)
    {
        delegate?.didSelectedLikeCell(self)
    }

}

protocol PhotoTableViewCellDelegate {
    func didSelectedLikeCell(_ cell:PhotoTableViewCell)
}
