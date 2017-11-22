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
        if let image = image
        {
            return UIImageJPEGRepresentation(image, 0.5)!
        }
        return nil
    }
    
    /* Initialize */
    init(img: UIImage, contents: String) {
        self.image = img
        self.contents = contents
    }
    
    init?(with dic: [String:String]) {
        guard let imgUrl = dic["post_img_url"] else { return nil }
        self.imgUrl = imgUrl
        guard let contents = dic["contents"]  else { return nil }
        self.contents = contents
    }
  
}
