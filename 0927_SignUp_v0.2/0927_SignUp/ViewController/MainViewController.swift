//
//  MainViewController.swift
//  0927_SignUp
//
//  Created by 김기윤 on 27/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class MainViewController: UIViewController {
    var exploreLabel: UILabel!
    var exploreImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreLabel.frame = CGRect(x: 0, y: 178, width: self.view.frame.size.width, height: 55)
        exploreLabel.textColor = .white
        exploreLabel.font = UIFont.systemFont(ofSize: 42, weight: .heavy)
        exploreLabel.textAlignment = .center
        exploreImg.image = UIImage(named: "Group 2")
        exploreImg.alpha = 0.7
        exploreImg.frame = CGRect(x: 0, y: 159, width: self.view.frame.size.width, height: 320)
        exploreImg.contentMode = .scaleAspectFill
        self.view.addSubview(exploreLabel)
        self.view.addSubview(exploreImg)
    }
}
