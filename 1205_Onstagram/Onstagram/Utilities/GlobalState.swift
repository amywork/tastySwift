//
//  GlobalState.swift
//  Onstagram
//
//  Created by Kimkeeyun on 04/12/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation

final class GlobalState {
    
    static var instance = GlobalState()
    private init() {
        loadUser()
        
        NotificationCenter.default
            .addObserver(forName:
                NSNotification.Name.uploadProfileImage,
                         object: nil,
                         queue: nil) { (noti) in
                            guard let newUrl = noti.object as? String else { return }
                            GlobalState.instance.user?.profileImageUrl = newUrl
                            GlobalState.instance.profileImageUrl = newUrl
                            NotificationCenter.default
                                .post(name: NSNotification.Name.userUpdatedInfo, object: nil)
                            }
        
    }
    
    enum Constants: String {
        case uid
        case email
        case profileImageUrl
        case users
        case posts
        case comments
        case following
        case likes
    }
    
    func loadUser() {
        guard let uid = uid, let email = email else { return }
        var newUser = User(uid: uid, email: email)
        newUser.profileImageUrl = profileImageUrl
        user = newUser
    }
    
    var user: User?
    
    var isLoggedin: Bool {
        let isEmpty = uid?.isEmpty ?? true
        return !isEmpty
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
    
    var profileImageUrl: String? {
        get {
            let profileImageUrl = UserDefaults.standard.string(
                forKey: Constants.profileImageUrl.rawValue)
            return profileImageUrl
        }set {
            UserDefaults.standard.set(newValue, forKey: Constants.profileImageUrl.rawValue)
        }
    }
    
}
