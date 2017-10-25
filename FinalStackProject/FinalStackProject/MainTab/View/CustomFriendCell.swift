//
//  CustomFriendCell.swift
//  FinalStackProject
//
//  Created by 김기윤 on 25/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class CustomFriendCell: UITableViewCell {
    
    var data:FriendDataModel? {
        didSet {
            guard let data = self.data else {
                return
            }
            self.textLabel?.text = data.nickName
            self.detailTextLabel?.text = data.myProfileDescription
            self.imageView?.image = UIImage(named:data.profileImageName)
        }
    }
    
}
