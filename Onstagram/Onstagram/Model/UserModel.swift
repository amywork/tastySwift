//
//  UserModel.swift
//  Onstagram
//
//  Created by Kimkeeyun on 21/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation
import UIKit

struct UserModel {
   
    /* Required */
    var uid: String
    
    /* Optional */
    // 01. Profile Image
    var profileImgUrl: String?
    var profileImg : UIImage?
    var profileImgData : Data? {
        if let img = self.profileImg {
            return img.generateJPEGData()
        }
        return nil
    }
    
    // 02. User Info
    var nickName: String?
    var statusMessage: String?
    
    // 03. User posts
    var posts = [PostModel]()
    
    /* Initialize */
    init(uid: String){
        self.uid = uid
    }
    
    /* Method */
    // addUserInfo
    mutating func addUserInfo(with snapshot: [String:Any]) {
        let imgUrl = snapshot["profile_img_url"] as? String
        self.profileImgUrl = imgUrl
        let nickName = snapshot["nickname"] as? String
        self.nickName = nickName
        let status = snapshot["status"] as? String
        self.statusMessage = status
       
        if let postArr = snapshot["POST"] as? [[String:[String:String]]] {
            for post in postArr {
                var newPost = PostModel(with: post.values.first!)
                newPost?.postKey = post.keys.first ?? ""
                self.posts.append(newPost!)
            }
        }
    }
    
}
