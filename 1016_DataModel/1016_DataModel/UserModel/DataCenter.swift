//
//  DataCenter.swift
//  1016_DataModel
//
//  Created by 김기윤 on 19/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
// Singleton DataCenter (UserModel과 데이터 파일ex.plist의 중개자 역할)
class DataCenter
{
    // Singleton Instance (shared Instance)
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
    
    // 최초에는 documentPath에 plist 파일이 없으므로 currentUser가 nil인 상태
    // 다시 로그인 할 떄는 AppDelegate에서 write 하면서 documentPath에 plist 파일이 생겼으므로 init 할 때 loadUserData() 되면서 currentUser가 생김
    func loadUserData() {
        // document Path는 String의 array로 들어오기 때문에, [0] + 내 파일명
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/UserPlist.plist"
        guard let documentDic = NSDictionary(contentsOfFile: documentPath) as? [String:Any] else { return }
        currentUser = UserModel(userDic: documentDic)
    }
    
    func writeUserData() -> Bool {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/UserPlist.plist"
        guard let data = currentUser else { return false }
        let newDic = data.dictionary
        let NSDic = NSDictionary(dictionary: newDic)
        NSDic.write(toFile: documentPath, atomically: true)
        return true
    }
    
    
    // UserModel의 데이터를 plist에 넣어주는 것 (Just Sample Code)
    func write(userData data: UserModel) {
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/UserPlist.plist"
        // 최초 한 번 UserPlist 파일을 document에 넣어놓는 것
        if !FileManager.default.fileExists(atPath: documentPath) {
            if let bundlePath = Bundle.main.path(forResource: "UserPlist", ofType: "plist") {
                do {
                    try FileManager.default.copyItem(atPath: bundlePath, toPath: documentPath)
                }catch {
                    print("FileManager.default.copyItem Fail")
                }
            }
        }
        
        let newDic = data.dictionary
        let NSDic = NSDictionary(dictionary: newDic)
        NSDic.write(toFile: documentPath, atomically: true)
        
    }
    
}
