//
//  AlbumCollectionCell.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 25..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class AlbumCollectionCell: UICollectionViewCell {
 
    
    var imageUrl:String?
    
    @IBOutlet var imgView:UIImageView!
    
    override func awakeFromNib() {
        self.imgView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutIfNeeded()
        self.imgView.layer.cornerRadius = self.imgView.frame.size.width/2
      
    }
    
}
