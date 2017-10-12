//
//  ViewController.swift
//  1012_DelegateProtocol
//
//  Created by 김기윤 on 12/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CustomViewDelegate {
    
    @IBOutlet var newCustomView: CustomView!
    var starimage: UIImage?
    
    func didSwitchedCustomView(_ customView: CustomView) {
        customView.titleLabel.text = "샌프란시스코로 떠나시겠습니까?"
        customView.imageView.image = nil
    }
    
    func didDeSwitchedCustomView(_ customView: CustomView) {
        customView.titleLabel.text = "Welcome to AirBnb"
        customView.imageView.image = UIImage(named: "Logo")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newCustomView.delegate = self
        starimage = UIImage(named: "staricon")
    }
    
}
