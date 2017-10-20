//
//  DetailViewController.swift
//  1020_FriendTableView
//
//  Created by 김기윤 on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

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
    }
}
