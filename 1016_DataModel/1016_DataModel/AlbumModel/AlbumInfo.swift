//
//  AlbumInfo.swift
//  1016_DataModel
//
//  Created by 김기윤 on 16/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
struct AlbumInfo {
    var albumTitle: String
    var artist: String
    var genre: String
    
    init?(dataDic:[String:Any]) {
        guard let albumTitle = dataDic["albumTitle"] as? String else { return nil }
        self.albumTitle = albumTitle
        
        guard let artist = dataDic["artist"] as? String else { return nil }
        self.artist = artist
        
        guard let genre = dataDic["genre"] as? String else { return nil }
        self.genre = genre
    }
}
