//
//  DataCenter.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

// Token 저장용으로 임시로 만든 데이터 센터 입니다.
open class DataCenter {
    
    static var shared: DataCenter = DataCenter()
    public var token: String = ""
    
    private init() {
    }
    
    public func saveCards(token: String) {
        self.token = token
    }
    
}
