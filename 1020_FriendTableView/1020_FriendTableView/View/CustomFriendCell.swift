//
//  CustomFriendCell.swift
//  1020_FriendTableView
//
//  Created by 김기윤 on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

//  Data만 관리하기 위한 CustomCell을 만든다.

import UIKit
class CustomFriendCell: UITableViewCell {

    var data:FriendDataModel? {
        didSet {
            self.textLabel?.text = self.data?.nickName
            self.detailTextLabel?.text = self.data?.statusDescription
            self.imageView?.image = UIImage(named: (self.data?.profileImageName)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
