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
        
        
    }
    
}
