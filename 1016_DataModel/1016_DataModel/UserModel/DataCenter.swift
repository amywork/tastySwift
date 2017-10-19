//
//  DataCenter.swift
//  1016_DataModel
//
//  Created by 김기윤 on 19/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

// Singleton DataCenter (UserModel과 데이터 파일의 중개자 역할)
class DataCenter
{
    // Singleton Instance
    static var main: DataCenter = DataCenter()
    var currentUser: UserModel?
    
    private init() {
        loadUserData()
    }
    
    func object(forkey: String) -> Any? {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/UserPlist.plist"
        guard let documentDic = NSDictionary(contentsOfFile: documentPath) as? [String:Any] else { return nil }
        return documentDic[forkey]
    }
    
    // plist 파일을 불러와서 UserModel에 넣어주는 것
    func loadUserData() {
        // document Path는 String의 array로 들어오기 때문에, [0] + 내 파일명
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/UserPlist.plist"
        guard let documentDic = NSDictionary(contentsOfFile: documentPath) as? [String:Any] else { return }
        currentUser = UserModel(userDic: documentDic)
    }
    
    
    
    // UserModel의 데이터를 plist에 넣어주는 것
    func write(userData data: UserModel) {
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/UserPlist.plist"
       
        let newDic = data.dictionary
        let NSDic = NSDictionary(dictionary: newDic)
        NSDic.write(toFile: documentPath, atomically: true)
        
        if !FileManager.default.fileExists(atPath: documentPath) {
            if let bundlePath = Bundle.main.path(forResource: "UserPlist", ofType: "plist") {
                do {
                    try FileManager.default.copyItem(atPath: bundlePath, toPath: documentPath)
                }catch {
                    print("FileManager.default.copyItem Fail")
                }
            }
        }
        
        
    }
    
}
