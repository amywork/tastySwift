//
//  PostModel.swift
//  Onstagram
//
//  Created by Kimkeeyun on 21/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation
import UIKit

struct PostModel {
    
    /* Required */
    var contents: String
    
    var imgUrl: String?
    var image: UIImage?
    var imageData: Data? {
        if let img = self.image {
            return img.generateJPEGData()
        }
        return nil
    }
    
    /* Initialize when you post */
    init(img: UIImage, contents: String) {
        self.image = img
        self.contents = contents
    }
    
    /* Initialize when you get posts from server */
    init?(with dic: [String:String]) {
        guard let imgUrl = dic["post_img_url"] else { return nil }
        self.imgUrl = imgUrl
        guard let contents = dic["contents"]  else { return nil }
        self.contents = contents
    }
  
}
