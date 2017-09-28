//
//  MainViewController.swift
//  0927_SignUp
//
//  Created by 김기윤 on 27/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class MainViewController: UIViewController {
    var exploreLabel = UILabel()
    var exploreImg = UIImageView()
    var dimmedImg = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        exploreLabel.frame = CGRect(x: 0, y: 160, width: self.view.frame.size.width, height: 60)
        exploreLabel.textColor = .white
        exploreLabel.text = "Explore"
        exploreLabel.font = UIFont.systemFont(ofSize: 46, weight: .heavy)
        exploreLabel.textAlignment = .center
        exploreImg.image = #imageLiteral(resourceName: "Background-1")
        exploreImg.alpha = 0.6
        exploreImg.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        exploreImg.contentMode = .scaleToFill
        
        dimmedImg.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        dimmedImg.backgroundColor = .black
        dimmedImg.alpha = 0.3
        self.view.addSubview(exploreImg)
        self.view.addSubview(dimmedImg)
        self.view.addSubview(exploreLabel)
    }
}

