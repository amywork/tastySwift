//
//  ViewController.swift
//  1120_ContentHugging
//
//  Created by 김기윤 on 20/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  https://www.raywenderlich.com/110393/auto-layout-visual-format-language-tutorial

import UIKit

class ViewController: UIViewController {

    var subView:UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(subView)
        
        // AutoLayout을 쓰려면 아래줄은 무조건 써줄것!
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        // NSLayoutConstraint
        let leadingContraint = NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10)
        view.addConstraint(leadingContraint)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

