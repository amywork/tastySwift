//
//  DataCenter.swift
//  1019_Setting
//
//  Created by 김기윤 on 19/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
class DataCenter {
    
    static var mainCenter: DataCenter = DataCenter()
    var nameList:[String] = []
    
    private init() {
        loadNameList()
    }
    
    // MARK: - (ADD)
    func addName(_ name: String) {
        nameList.append(name)
        saveNameList()
    }
    
    // MARK: - (REMOVE)
    func removeName(_ name: String) {
        guard let index = nameList.index(of: name) else { return }
        nameList.remove(at: index)
        saveNameList()
    }
    
    // MARK: - (READ) plist -> nameList:[String]
    func loadNameList() {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/name.plist"
        guard let newArr = NSArray(contentsOfFile: documentPath) as? [String] else { return }
        
        nameList = newArr
    }
    
    // MARK: - (WRITE) nameList:[String] -> plist
    func saveNameList() {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/name.plist"
        
        let newArr = NSArray(array: nameList)
        newArr.write(toFile: documentPath, atomically: true)
    }
    
}
