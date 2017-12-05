//
//  DataManager.swift
//  FinalStackProject
//
//  Created by Kimkeeyun on 05/12/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    enum Constants: String {
        case name
        case refreshTokenKey
        case ownerKey
        case repoKey
        case reposKey
    }
    
    func save() {
        
        
        
    }
    
    
    var owner: String {
        get {
            let owner = UserDefaults.standard.string(forKey: Constants.ownerKey.rawValue) ?? ""
            return owner
        }set {
            UserDefaults.standard.set(newValue, forKey: Constants.ownerKey.rawValue)
        }
    }
    
    
    
}
