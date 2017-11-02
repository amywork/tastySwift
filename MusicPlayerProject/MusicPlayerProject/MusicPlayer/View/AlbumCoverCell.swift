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

