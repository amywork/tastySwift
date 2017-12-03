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
    var albumName:String?
    var lyrics:String?

    var songURL:URL?
    var imageData:Data?
    var image:UIImage?{
        if let data = self.imageData
        {
            return UIImage(data:data)
        }
        return nil
    }
    
    init(data: [AVMetadataItem]) {
        for item in data {
            if let key = item.commonKey?.rawValue {
                switch key {
                case "title":
                    title = item.value as? String
                case "artist":
                    artist = item.value as? String
                case "artwork":
                    imageData = item.dataValue
                case "albumName":
                    albumName = item.value as? String
                default:
                    break
                }
            }
        }
    }
    
}
