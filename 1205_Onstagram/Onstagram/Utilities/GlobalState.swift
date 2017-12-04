//
//  GlobalState.swift
//  Onstagram
//
//  Created by Kimkeeyun on 04/12/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation

final class GlobalState {
    
    static let instance = GlobalState()
    
    enum Constants: String {
        case uid
        case email
        case users
        case posts
        case comments
        case following
        case likes
    }
    
    var uid: String? {
        get {
            let uid = UserDefaults.standard.string(
                forKey: Constants.uid.rawValue)
            return uid
        }set {
            UserDefaults.standard.set(newValue, forKey: Constants.uid.rawValue)
        }
    }
    
    var email: String? {
        get {
            let email = UserDefaults.standard.string(
                forKey: Constants.email.rawValue)
            return email
        }set {
            UserDefaults.standard.set(newValue, forKey: Constants.email.rawValue)
        }
    }
    
    var isLoggedin: Bool {
        let isEmpty = uid?.isEmpty ?? true
        return !isEmpty
    }
    
}
