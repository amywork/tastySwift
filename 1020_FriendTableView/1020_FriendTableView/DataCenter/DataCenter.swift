//
//  DataCenter.swift
//  1020_FriendTableView
//
//  Created by 김기윤 on 19/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

class DataCenter {
    
    static var mainCenter:DataCenter = DataCenter()
    var friendList:[FriendDataModel] = []
    private init() {
        loadData()
    }
    
    // add to friendList
    func addFriend(with data:FriendDataModel) {
        friendList.append(data)
        saveData()
    }
    
    // plist -> Model
    func loadData() {
        guard let bundlePath = Bundle.main.path(forResource: "FriendInfo", ofType: "plist") else { return }
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/FriendInfo.plist"
        
        if !FileManager.default.fileExists(atPath: documentPath) {
            do {
                try FileManager.default.copyItem(atPath: bundlePath, toPath: documentPath)
            }catch {
                print("No such File")
            }
        }
        
        guard let dataArr = NSArray(contentsOfFile: documentPath) as? [[String:String]] else { return }
        for data in dataArr {
            guard let newModel = FriendDataModel(with: data) else { return }
            friendList.append(newModel)
        }
        
    }

    // Model -> plist
    func saveData() {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/FriendInfo.plist"
        let newArr = NSArray(array: friendList)
        newArr.write(toFile: documentPath, atomically: true)
    }
    
    
}
