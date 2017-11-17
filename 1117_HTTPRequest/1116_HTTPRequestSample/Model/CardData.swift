//
//  CardData.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import UIKit

struct CardData: Codable {
    
    // MARK -- : Title & Content property
    var title: String
    var content: String
    
    var param: [String:String] {
        return ["title":title,"content":content]
    }
    
    // MARK -- : Image property
    var imgCoverUrl: String?
    var imgData: Data?
    
    var image:UIImage? {
        if let imgData =
            imgData {
            return UIImage(data:imgData)
        }
        return nil
    }
    
    // Decoding (JSON -> MODEL)
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case content = "content"
        case imgCoverUrl = "img_cover"
        case imgData = "imgData"
    }
    
    // Encoding (MODEL -> JSON)
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
    }
    
    // When we create new post
    init(title:String, imgData:Data, content:String) {
        self.title = title
        self.imgData = imgData
        self.content = content
    }
    
    // when we request all posts
    // init with json (dic)
    init?(dic:[String:Any]) {
        guard let title = dic["title"] as? String else { return nil }
        self.title = title
        guard let imgCoverString = dic["img_cover"] as? String else { return nil }
        self.imgCoverUrl = imgCoverString
        guard let content = dic["content"] as? String else { return nil }
        self.content = content
    }
    
    
    /*
     // init 할 때 throws 할 수 있다고 말해주는 것!
     init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     title = try container.decode(String.self, forKey: .title)
     content = try container.decode(String.self, forKey: .content)
     imgCoverUrl = try container.decode(String.self, forKey: .imgCoverUrl)
     }*/
    
}


