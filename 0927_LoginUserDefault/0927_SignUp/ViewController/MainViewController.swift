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
    var dimmedImg: UIView!
    var exitIcon: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        exploreLabel = UILabel()
        exploreImg = UIImageView()
        dimmedImg = UIView()
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
        exitIcon = UIButton(frame: CGRect(x: self.view.frame.size.width/2-15, y: self.view.frame.size.height-46, width: 30, height: 30))
        exitIcon.setTitle("Exit", for: .normal)
        exitIcon.setTitleColor(.white, for: .normal)
        exitIcon.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        exitIcon.addTarget(self, action: #selector(didTapExitButton), for: .touchUpInside)
        self.view.addSubview(exploreImg)
        self.view.addSubview(dimmedImg)
        self.view.addSubview(exploreLabel)
        self.view.addSubview(exitIcon)
    }
    
    @objc func didTapExitButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil) // 화면 내리기
    }
}

