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
        }willSet {
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        coverImageView.layer.cornerRadius = coverImageView.frame.size.width/2
    }
    
    
}
