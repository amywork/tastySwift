//
//  PlayLists.swift
//  1016_DataModel
//
//  Created by 김기윤 on 17/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation


enum listType {
    case playList
    case userPlayList
}

struct Playlist {

    var type: listType?
    var playListID: String?
    var userPlayListID: String?
    var title: String
    var mainImgUrl: String
    var thumbImgUrl: String
    var songCnt: Int
    var isPremium: Bool // YN
    var monthlyYM: String // YYYYMM
    
    init?(dataDic:[String:Any]) {
        
        if let listStr1 = dataDic["id"] as? String {
            self.type = .playList
            self.playListID = listStr1
        }else if let listStr2 = dataDic["up_id"] as? String {
            self.type = .userPlayList
            self.userPlayListID = listStr2
        }else {
            return nil
        }

        guard let title = dataDic["title"] as? String else { return nil }
        self.title = title
        
        guard let mainImgUrl = dataDic["main_img_url"] as? String else { return nil }
        self.mainImgUrl = mainImgUrl
        
        guard let thumbImgUrl = dataDic["thumb_img_url"] as? String else { return nil }
        self.thumbImgUrl = thumbImgUrl
        
        guard let songCnt = dataDic["song_cnt"] as? Int else { return nil }
        self.songCnt = songCnt
        
        guard let isPremium = dataDic["is_premium"] as? String else { return nil }
        if isPremium == "Y" {
            self.isPremium = true
        }else if isPremium == "N" {
            self.isPremium = false
        }else {
            return nil
        }
    
        guard let monthlyYM = dataDic["monthly_ym"] as? Int else { return nil }
        let year: Int = monthlyYM/100
        let month: Int = monthlyYM%100
        self.monthlyYM = "\(year)년 \(month)월"
    }


}
