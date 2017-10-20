//
//  ProfileTableViewCell.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 20..
//  Copyright © 2017년 WingsCompany. All rights reserved.
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
