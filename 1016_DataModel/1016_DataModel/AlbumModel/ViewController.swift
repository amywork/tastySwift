//
//  ViewController.swift
//  1016_DataModel
//
//  Created by 김기윤 on 16/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    let albumTelevision:Dictionary<String,Any> =
        ["albumInfo":["albumTitle":"Television",
                      "artist":"지코(ZICO)",
                      "genre":"hiphop"],
         "songList":[["songTitle":"천재",
                      "trackNum":1,
                      "artist":"지코(ZICO)",
                      "writer":"지코, Poptime",
                      "playTime":12340,
                      "playURL":"http://music.naver.com/123"],
                     ["songTitle":"Artist",
                      "trackNum":2,
                      "artist":"지코(ZICO)",
                      "writer":"지코, Poptime",
                      "playTime":10130,
                      "playURL":"http://music.naver.com/124"],
                     ["songTitle":"ANTI",
                      "trackNum":3,
                      "artist":"지코(ZICO)",
                      "writer":"지코, Poptime",
                      "playTime":12134,
                      "playURL":"http://music.naver.com/126"],
                     ["songTitle":"FANXY CHILD",
                      "trackNum":4,
                      "artist":"지코(ZICO)",
                      "writer":"지코, Poptime",
                      "playTime":12134,
                      "playURL":"http://music.naver.com/126"],
                     ["songTitle":"She's a baby",
                      "trackNum":5,
                      "artist":"지코(ZICO)",
                      "writer":"지코, Poptime",
                      "playTime":12134,
                      "playURL":"http://music.naver.com/126"],
                     ["songTitle":"Bermuda Triangle",
                      "trackNum":6,
                      "artist":"지코(ZICO)",
                      "writer":"지코, Poptime",
                      "playTime":12134,
                      "playURL":"http://music.naver.com/126"]
            ]
    ]
    
    var songs: [String:Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let zicoTelevisionAlbum = AlbumModel(dataDic: albumTelevision) {
            var playTime: String {
                let second = zicoTelevisionAlbum.songList[0].playTime
                return secondToTime(second: second)
            }
            var songTitle: String = zicoTelevisionAlbum.songList[0].songTitle
            
            for song in zicoTelevisionAlbum.songList {
                songs.append(song)
            }
        }
	    
    }

    private func secondToTime(second: Int) -> String {
        let second = second
        var timeStr = ""
        if second < 60 {
            timeStr = "\(second)초"
        }else if second >= 60 && second < 3600 {
            timeStr = "\(second/60)분 \(second%60)초"
        }else {
            timeStr = "\(second/3600)시간 \((second%3600)/60)분 \((second%3600)%60)초"
        }
        return timeStr
    }

}

/*List안에 실데이터가 있다고 가정함
let List = [["String":"String"],["String":"String"]]

for eventDic in List {
    if let dic = EventData(dataDic: eventDic) {
        self.eventList.append(dic)
    }
} */
