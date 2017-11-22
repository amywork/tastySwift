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
    var email: String
    var uid: String
    
    /* Optional */
    // 01. Profile Image
    var profileImg : UIImage?
    var profileImgUrl: String?
    var profileImgData : Data? {
        if let img = self.profileImg {
            return UIImageJPEGRepresentation(img, 0.5)!
        }
        return nil
    }
    
    // 02. User Info
    var nickName: String?
    var status: String?
    
    // 03. User posts
    var posts = [PostModel]()
    
    /* Initialize */
    init(email: String, uid: String){
        self.email = email
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
        self.status = status
        let postArr = snapshot["POST"] as! [[String:String]]
        for post in postArr {
            guard let newPost = PostModel(with: post) else { return }
            self.posts.append(newPost)
        }
    }
    
}
