//
//  AlbumCoverCell.swift
//  CollectionViewProject
//
//  Created by 김기윤 on 26/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class AlbumCoverCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    var data:AlbumDataModel? {
        didSet {
            coverImageView.image = data?.image
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded() // AutoLayout be arranged
        coverImageView.layer.cornerRadius = coverImageView.bounds.width/2
    }
    
}

/*Drop Shadow 넣고 싶은데...😂
extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
*/
