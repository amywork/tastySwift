//
//  ViewController.swift
//  0926_XcodeUserInterface
//
//  Created by 김기윤 on 25/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let subview: UIView = UIView()
    override func viewDidLoad() {

        super.viewDidLoad()

        let topView: UIView = UIView(frame: CGRect(x: 15, y: 15, width: self.view.frame.width-30, height: 100))
        topView.frame = CGRect(origin: CGPoint(x: 30, y: 30), size: CGSize(width: 100, height: 100))
        topView.backgroundColor = UIColor.yellow
        topView.layer.borderWidth = 8
        topView.layer.borderColor = UIColor.black.cgColor
        //UIColor라는 class 안에 black이라는 프로퍼티가 있고, cgColor로 변환
        topView.layer.cornerRadius = 20
        self.view.addSubview(topView)
        
        let bottomView: UIView = UIView(frame: CGRect(x: 15, y: self.view.frame.size.height-115 , width: self.view.frame.width-30, height: 100))
        bottomView.backgroundColor = UIColor.brown
        self.view.addSubview(bottomView)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        subview.frame = CGRect(x: 15, y: 15, width: self.view.frame.size.width - 30, height: 100)
    }
    
    func configureLayerProperty(label: UILabel) {
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.blue.cgColor
    }

}

