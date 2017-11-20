//
//  DataCenter.swift
//  Onstagram
//
//  Created by Kyuhan Shin on 2017. 11. 20..
//  Copyright © 2017년 Kyuhan Shin. All rights reserved.
//

import Foundation

class DataCenter {
    static var shared: DataCenter = DataCenter()
    var currentUser: UserModel?
    
    private init(){
    }
}
