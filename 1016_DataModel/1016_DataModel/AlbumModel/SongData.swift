//
//  SongData.swift
//  1016_DataModel
//
//  Created by 김기윤 on 16/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
struct SongData {
    var songTitle: String
    var trackNum: Int
    var playTime: Int
    var artist: String
    var writer: String
    var playURL: String
    
    init?(dataDic:[String:Any]) {
        guard let songTitle = dataDic["songTitle"] as? String else { return nil }
        self.songTitle = songTitle
        
        guard let trackNum = dataDic["trackNum"] as? Int else { return nil }
        self.trackNum = trackNum
        
        guard let playTime = dataDic["playTime"] as? Int else { return nil }
        self.playTime = playTime
        
        guard let artist = dataDic["artist"] as? String else { return nil }
        self.artist = artist
        
        guard let writer = dataDic["writer"] as? String else { return nil }
        self.writer = writer
        
        guard let playURL = dataDic["playURL"] as? String else { return nil }
        self.playURL = playURL
    }
}
