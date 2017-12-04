//
//  Post.swift
//  Onstagram
//
//  Created by Kimkeeyun on 03/12/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation

struct Post {
    
    var id: String?
    
    let uid: String
    let imageUrl: String
    let caption: String
    let creationDate: Date
    
    var hasLiked = false
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
   
}

