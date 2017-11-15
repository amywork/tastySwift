//
//  Model.swift
//  1116_URL
//
//  Created by 김기윤 on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

struct dataModel {
    
    var title: String
    var imgCover: String
    
    init?(with dic: [String:Any]) {
        guard let title = dic["title"] as? String else { return nil }
        self.title = title
     
        guard let imgCover = dic["img_cover"] as? String else { return nil }
        self.imgCover = imgCover
    }
    
}
