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
//            coverImageView.layer.cornerRadius = coverImageView.bounds.width/2
//            coverImageView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
//            coverImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
//            coverImageView.layer.shadowOpacity = 0.5
        }
    }
    
    
}
