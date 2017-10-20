//
//  DetailViewController.swift
//  1020_FriendTableView
//
//  Created by 김기윤 on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var data: FriendDataModel?
    
    //MARK: - Image
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    //MARK: - Detail Label
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let realData = data {
            self.bgImageView.image = UIImage(named: realData.bgImageName)
            self.profileImageView.image = UIImage(named: realData.profileImageName)
            self.nameLabel.text = realData.nickName
            self.descriptionTextView.text = realData.myProfileDescription
            self.phoneLabel.text = realData.phoneNumber
            self.emailLabel.text = realData.email
            profileImageView.layer.cornerRadius = profileImageView.bounds.size.width/2
            profileImageView.clipsToBounds = true
            self.navigationItem.title = "detail"
        }
    }
}
