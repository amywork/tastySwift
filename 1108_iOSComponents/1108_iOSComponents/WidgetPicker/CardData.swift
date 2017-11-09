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
    var imgData: Data
    var isLike: Bool = false
    
    var dictionaryData:[String:Any] {
        return ["name":cardName,"data":imgData,"isLike":isLike]
    }

    var image:UIImage?{
        return UIImage(data:imgData)
    }
    
    init(name:String, data:Data)
    {
        self.cardName = name
        self.imgData = data
    }
    
    init?(dataDic:[String:Any])
    {
        guard let title = dataDic["name"] as? String else {return nil}
        self.cardName = title
        guard let data = dataDic["data"] as? Data else {return nil}
        self.imgData = data
        guard let isLike = dataDic["isLike"] as? Bool else {return nil}
        self.isLike = isLike
    }

}
