//
//  SettingVC.swift
//  Onstagram
//
//  Created by 김기윤 on 21/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let iv = UIImageView()
        view.addSubview(iv)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iv.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        iv.image = #imageLiteral(resourceName: "Setting")
        iv.contentMode = .scaleAspectFit
        
        let lv = UILabel()
        view.addSubview(lv)
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lv.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lv.text = "Setting 화면 * 나중에 추가"
        lv.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
    }

}
