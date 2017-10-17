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
        guard let albumInfoDic = dataDic["albumInfo"] as? [String:Any] else { return nil }
        self.albumInfo = AlbumInfo(dataDic: albumInfoDic)!
        
        guard let songDicArr = dataDic["songList"] as? [[String:Any]] else { return nil }
        for songDic in songDicArr {
            songList.append(SongData(dataDic: songDic)!)
        }
    }
}

