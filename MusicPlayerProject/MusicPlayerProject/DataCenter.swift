//
//  DataCenter.swift - - Singleton
//  CollectionViewProject
//
//  Created by 김기윤 on 26/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import AVFoundation
class DataCenter {
    
    // MARK: - Singleton
    static var main:DataCenter = DataCenter()
    private init() {
        loadSongData()
        loadUserData()
    }
    
    // MARK: - Data Property
    var currentUser: UserModel?
    var albumList:[AlbumDataModel] = []

    // MARK: - FileManager
    private var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // MARK: - method
    func loadUserData() {
        let userDataURL = documentDirectory.appendingPathComponent("CurrentUser.plist")
        let documentPath = userDataURL.path
        print(documentPath)
        guard let documentDic = NSDictionary(contentsOfFile: documentPath) as? [String:Any] else { return }
        currentUser = UserModel(userDic: documentDic)
    }
    
    func writeUserData() -> Bool {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/CurrentUser.plist"
        guard let data = currentUser else { return false }
        let newDic = data.dictionary
        let NSDic = NSDictionary(dictionary: newDic)
        NSDic.write(toFile: documentPath, atomically: true)
        return true
    }
    
    func validateUserInfo(username:String, password: String) -> Bool {
        if let model = self.currentUser {
            if model.userID == username && model.userPWD == password {
                return true
            }
        }
        return false
    }
    
    func loadSongData() {
        for i in 0...10 {
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
