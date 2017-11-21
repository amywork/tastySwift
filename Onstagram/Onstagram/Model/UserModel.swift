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
   
    var email: String
    var uid: String
    
    var profileImg : UIImage?
    var profileImgData : Data? {
        if let img = self.profileImg {
            return UIImageJPEGRepresentation(img, 0.5)!
        }
        return nil
    }
    
    var profileImgUrl: String?
    var nickName: String?
    var status: String?
    
    var posts = [PostModel]()
    
    init(email: String, uid: String){
        self.email = email
        self.uid = uid
    }
}
