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
                      "genre":"국내 hiphop"],
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
                      "playURL":"http://music.naver.com/126"]
            ]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DataCenter Test
        DataCenter.main.loadUserData()

    }

}

/*List안에 실데이터가 있다고 가정함
let List = [["String":"String"],["String":"String"]]

for eventDic in List {
    if let dic = EventData(dataDic: eventDic) {
        self.eventList.append(dic)
    }
} */
