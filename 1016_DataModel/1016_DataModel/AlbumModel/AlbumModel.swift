//
//  AlbumModel.swift
//  1016_DataModel
//
//  Created by 김기윤 on 16/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
struct AlbumModel {
 
    var albumInfo: AlbumInfo
    var songList: [SongData] = []
    
    init?(dataDic: [String:Any]) {
        guard let albumInfo = dataDic["albumInfo"] as? [String:Any] else { return }
        self.albumInfo = AlbumInfo(dataDic: albumInfo)!
        
        guard let songLists = dataDic["songList"] as? [[String:Any]] else { return }
        for song in songLists {
            songList.append(SongData(dataDic: song))!
        }
  
    }
    
}
