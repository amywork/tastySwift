//  FinalStackProject
//
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import UIKit

struct ExploreData {
    
    var name: String
    var category: String
    var URL: String
    var imageStr: String
    var memo: String
    var image: UIImage? {
        if let image = UIImage(named: self.imageStr) {
            return image
        }
        return nil
    }
    
    var exploreDataDic: [String:String] {
        return ["name":self.name,
                "category":self.category,
                "URL":self.URL,
                "imageStr":self.imageStr,
                "memo":self.memo
        ]
    }
    
    init?(with dic: [String:String]) {
        guard let name = dic["name"] else { return nil }
        self.name = name
        
        guard let category = dic["category"] else { return nil }
        self.category = category
        
        guard let url = dic["URL"] else { return nil }
        self.URL = url
        
        guard let imageStr = dic["imageStr"] else { return nil }
        self.imageStr = imageStr
        
        guard let memo = dic["memo"] else { return nil }
        self.memo = memo
    }
    
}



