//
//  LikeInfo.swift
//  1016_DataModel
//
//  Created by 김기윤 on 17/10/2017.
//  Copyright © 2017 younari. All rights reserved.

import Foundation
struct LikeInfo {
    
    enum likeType: String {
        case song = "song"
        case userPlayList  = "up"
        case artist = "artist"
    }

    var type: likeType
    var ID: String
    var likeCnt: Int
    var isLike: Bool

    init?(data: [String:Any]) {

        guard let likeCnt = data["like_cnt"] as? Int else { return nil }
        self.likeCnt = likeCnt

        guard let isLike = data["is_like"] as? String else { return nil }
        switch isLike {
        case "Y":
            self.isLike = true
        case "N":
            self.isLike = false
        default:
            return nil
        }

        if let str = data["song"] as? String {
            self.type = .song
            self.ID = str
        }else if let str = data["up"] as? String {
            self.type = .userPlayList
            self.ID = str
        }else if let str = data["artist"] as? String {
            self.type = .artist
            self.ID = str
        }else {
            return nil
        }
    }

    
}
