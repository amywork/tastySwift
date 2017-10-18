//
//  UserService.swift
//  1018_Fanxy
//
//  Created by 김기윤 on 18/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation


struct UserService {
    
    var model: Users?
    static var sharedInstance: UserService = UserService()
    
    init() {
        // PList에서 정보를 가져와서 Model에 넣는다.

    }

    func loadData() {
        let dataURL = FileManager.default.urls(
            for: FileManager.SearchPathDirectory.documentDirectory,
            in: FileManager.SearchPathDomainMask.userDomainMask).first!
        
        let dataStrPath = dataURL.path
        if !FileManager.default.fileExists(atPath: dataStrPath) {
            guard let plistURL = Bundle.main.url(forResource: "UserData", withExtension: "plist") else { return }
            // 오류를 던질 수 있으므로 try! (에러 무시)
            try! FileManager.default.copyItem(at: plistURL, to: dataURL)
        }
        
        
        
        
        
    }
}
