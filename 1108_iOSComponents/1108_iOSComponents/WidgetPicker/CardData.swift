//
//  CardData.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import UIKit

struct CardData {
    var cardName: String
    var cardImgName: String?
    var imgData: Data?
    var img: UIImage?

    init(name:String, img:UIImage) {
        self.cardName = name
        self.img = img
    }
    
    init(name:String, imgName:String) {
        self.cardName = name
        self.cardImgName = imgName
    }
    
    init(name:String, data:Data) {
        self.cardName = name
        self.imgData = data
    }

}
