//
//  CardData.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import UIKit

struct CardData {
    
    var name: String
    var imgData: Data
    
    var cardDic:[String:Any] {
        return ["name":name,"data":imgData]
    }
    
    var image:UIImage?{
        return UIImage(data:imgData)
    }
    
    init(name:String, data:Data)
    {
        self.name = name
        self.imgData = data
    }
    
    init?(dic:[String:Any])
    {
        guard let title = dic["name"] as? String else { return nil }
        self.name = title
        guard let data = dic["data"] as? Data else { return nil }
        self.imgData = data
    }
    
}

