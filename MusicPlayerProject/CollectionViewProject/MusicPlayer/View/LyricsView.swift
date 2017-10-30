//
//  LyricsView.swift
//  CollectionViewProject
//
//  Created by 김기윤 on 30/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class LyricsView: UIView {
    
    @IBOutlet weak var textLabel: UILabel!
    var data:AlbumDataModel? {
        didSet {
            self.textLabel.text = self.data?.lyrics
        }
    }
    
    
        
}
