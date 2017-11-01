//
//  DataCenter.swift
//  CollectionViewProject
//
//  Created by 김기윤 on 26/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import AVFoundation

class DataCenter {
    
    static var main:DataCenter = DataCenter()
    var albumList:[AlbumDataModel] = []
    
    private init() {
        loadSongData()
    }
    
    func loadSongData() {
        for i in 0..<30 {
            if let url = Bundle.main.url(forResource: "\(i)", withExtension: "mp3")
            {
                let asset = AVURLAsset(url: url)
                let metaData:[AVMetadataItem] = asset.metadata
                var newAlbum = AlbumDataModel(data: metaData)
                newAlbum.lyrics = asset.lyrics
                newAlbum.songURL = url
                albumList.append(newAlbum)
            }
        }
    }
    
}
