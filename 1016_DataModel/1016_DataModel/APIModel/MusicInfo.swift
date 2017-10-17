//
//  MusicInfo.swift
//  1016_DataModel
//
//  Created by Kimkeeyun on 17/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
enum LikeType
{
    case song
    case playlist
    case artist
}

struct likeInfo
{
    var type:LikeType
    var count:Int
    var isLike:Bool
    /*
     - song: object key for song.
     - id: object key (song_id)
     - like_cnt
     - is_like: Y/N
     */
    init?(data:[String:Any])
    {
        if let songData = data["song"] as? [String:Any],
            let dic = songData["id"] as? [String:Any]
        {
            type = .song
            count = dic["like_cnt"] as? Int ?? 0
            if let likeKey = data["like_cnt"] as? String,
                (likeKey == "Y" || likeKey == "N")
            {
                self.isLike = likeKey == "y" ? true : false
            }else
            {
                self.isLike = false
            }
            
        }else if let playlistData = data["up"] as? [String:Any],
            let dic = playlistData["id"] as? [String:Any]
        {
            type = .playlist
            count = dic["like_cnt"] as? Int ?? 0
            
            if let likeKey = data["is_like"] as? String,
                (likeKey == "Y" || likeKey == "N")
            {
                self.isLike = likeKey == "y" ? true : false
            }else
            {
                self.isLike = false
            }
            
        }else if let artistData = data["artist"] as? [String:Any],
            let dic = artistData["id"] as? [String:Any]
        {
            type = .artist
            count = dic["like_cnt"] as? Int ?? 0
            if let likeKey = data["like_cnt"] as? String,
                (likeKey == "Y" || likeKey == "N")
            {
                self.isLike = likeKey == "y" ? true : false
            }else
            {
                self.isLike = false
            }
            
        }else
        {
            return nil
        }
    }
    
    //두번째 방법
    //    init?(data:[String:Any])
    //    {
    //        for (key,value) in data
    //        {
    //            //타입 설정
    //            switch key
    //            {
    //            case "song":
    //                type = .song
    //            case "up":
    //                type = .playlist
    //            case "artist":
    //                type = .artist
    //            }
    //            //벗겨내기
    //            guard let data  = value as? [String:Any],
    //            let dic = data["id"] as? [String:Any] else {return nil}
    //            //실제 데이터 가져오기
    //            count = dic["like_cnt"] as? Int ?? 0
    //            if let likeKey = data["like_cnt"] as? String,
    //                (likeKey == "Y" || likeKey == "N")
    //            {
    //                self.isLike = likeKey == "y" ? true : false
    //            }else
    //            {
    //                self.isLike = false
    //            }
    //        }
    //    }
}
enum PlayListType
{
    case origin
    case custom
}
struct PlayList
{
    var type:PlayListType
    var id:Int
    var title:String
    var mainImgURL:String?
    var thumbImgURL:String?
    var totalSongCount:Int
    var isPremium:Bool
    var date:Date?
    init?(data:[String:Any])
    {
        if let id = data["id"] as? Int
        {
            self.type = .origin
            self.id = id
        }else if let id = data["upid"] as? Int
        {
            self.type = .custom
            self.id = id
        }else
        {
            return nil
        }
        
        guard let title = data["title"] as? String else {return nil}
        self.title = title
        
        self.mainImgURL = data["main_img_url"] as? String
        self.thumbImgURL = data["thumb_img_url"] as? String
        self.totalSongCount = data["song_cnt"] as? Int ?? 0
        
        if let premium = data["isPremium"] as? String,
            (premium == "Y" || premium == "N")
        {
            self.isPremium = premium == "y" ? true : false
        }else
        {
            self.isPremium = false
        }
        
        guard let date = data["monthly_ym"] as? Int else { return nil}
        
        let year = date/100
        let month = date%100
        let calender = Calendar(identifier: .gregorian)
        
        var components = DateComponents()
        components.year = year
        components.month = month
        
        self.date = calender.date(from: components)
        
        print(date)
    }
}
