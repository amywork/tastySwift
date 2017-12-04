//
//  API.swift
//  Onstagram
//
//  Created by Kimkeeyun on 04/12/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation
import Firebase

protocol API {
    typealias FetchPostsHandler = ([Post]) -> Void
    typealias FetchCommentsHandler = (User?) -> Void
    typealias FetchFollowersHandler = (User?) -> Void
    func fetchPosts(uid: String, handler: @escaping FetchPostsHandler)
    //func fetchComments(handler: @escaping FetchCommentsHandler)
    //func fetchFollowers(handler: @escaping FetchFollowersHandler)
}



struct FirebaseAPI: API {
    
    let baseReference = Database.database().reference()
 
    func fetchPosts(uid: String, handler: @escaping FetchPostsHandler) {
        baseReference.child(GlobalState.Constants.posts.rawValue)
            .child(uid)
            .observeSingleEvent(of: .value) { (snapshot) in
                guard let dictionaries = snapshot.value as? [String: Any] else { return }
                var posts = [Post]()
                dictionaries.forEach({ (key, value) in
                    guard let dictionary = value as? [String: Any] else { return }
                    var post = Post(uid: uid , dictionary: dictionary)
                    post.key = key
                    posts.append(post)
                    self.baseReference.child("likes")
                        .child(key)
                        .child(uid)
                        .observeSingleEvent(of: .value, with: { (snapshot) in
                            if let value = snapshot.value as? Int, value == 1 {
                                post.hasLiked = true
                            } else {
                                post.hasLiked = false
                            }
                            })
                        })
                DispatchQueue.main.async {
                    handler(posts)
                }
        }
    }
    
    /*
    func fetchUser(uid: String) -> User {
        baseReference.child(GlobalState.Constants.users.rawValue)
            .child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                let userDictionary = snapshot.value as! [String: Any]
                let email = userDictionary["email"] as! String
                return User(uid: uid, email: email)
            })
    }
    
    func fetchFollowers() {
        guard let user = GlobalState.instance.user else { return }
        var followers = [User]()
        baseReference.child(GlobalState.Constants.following.rawValue)
            .child(user.uid)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                guard let userIdsDictionary = snapshot.value as? [String: Any] else { return }
                userIdsDictionary.forEach({ (key, value) in
                    let follower = self.fetchUser(uid: key)
                    followers.append(follower)
                })
            }) { (err) in
                print("Failed to fetch following user ids:", err)
        }
    }
     */
    
}
