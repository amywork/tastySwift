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
    
    var image: UIImage
    var imageData: Data {
        return UIImageJPEGRepresentation(image, 0.5)!
    }
    
    var title: String
    var contents: String
    
    init(img: UIImage, title: String, contents: String) {
        self.image = img
        self.title = title
        self.contents = contents
    }
  
}
