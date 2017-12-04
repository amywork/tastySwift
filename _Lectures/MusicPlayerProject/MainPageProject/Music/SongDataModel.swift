//
//  SongDataModel.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 26..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

let songDirectory = "Song/"
struct SongDataModel {
    var songUrl:String
    var title:String = "이름 없음"
    var artistName:String?
    
    var artworkImgData:Data?
    var artworkImg:UIImage?{
        if let data = self.artworkImgData
        {
            return UIImage(data:data)
        }
        return nil
    }
    
    var lyric:String?
    
    init?(fileName:String)
    {
        self.songUrl = songDirectory + fileName
        
        guard let url = Bundle.main.url(forResource: songDirectory+fileName,  withExtension: "mp3") else { return nil}
        
        let asset = AVURLAsset(url: url)
        let metaData:[AVMetadataItem] = asset.metadata
        
        self.lyric = asset.lyrics
        
        for item in metaData
        {
            if let key = item.commonKey?.rawValue
            {
                switch key
                {
                case "title":
                    if let title =  item.value as? String
                    {
                        self.title = title
                    }
                case "artist" :
                    self.artistName = item.value as? String
                case "artwork":
                    //artistLb.text = item.value
                    self.artworkImgData = item.dataValue
                default:
                    break
                    
                }
            }
        }
    }
    
}

