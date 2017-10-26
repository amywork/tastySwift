//
//  AlbumModel.swift
//  CollectionViewProject
//
//  Created by 김기윤 on 26/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

struct AlbumDataModel {
    
    var title:String?
    var artist:String?
    var image:UIImage?
    var lyric:String?
    
    init(data: [AVMetadataItem]) {
        for item in data {
            if let key = item.commonKey?.rawValue {
                switch key {
                case "title":
                    title = item.value as? String
                case "artist":
                    artist = item.value as? String
                case "artwork":
                    let data = item.dataValue
                    image = UIImage(data: data!) ?? #imageLiteral(resourceName: "Artist")
                default:
                    break
                }
            }
        }
    }
    
}
