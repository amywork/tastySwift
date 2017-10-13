//
//  CustomView.swift
//  1012_DelegateProtocol
//
//  Created by 김기윤 on 12/10/2017.
//  Copyright © 2017 younari. All rights reserved.

import UIKit
class CustomView: UIView {
    
    var delegate: CustomViewDelegate?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var switchBtn: UISwitch!
    
    @IBAction func switching(_ sender: UISwitch) {
        if sender.isOn {
            delegate?.didSwitchedCustomView(self)
        }else {
            delegate?.didDeSwitchedCustomView(self)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switchBtn.isOn = false
        imageView.contentMode = UIViewContentMode.center
    }
}

protocol CustomViewDelegate {
    func didSwitchedCustomView(_ customView: CustomView)
    func didDeSwitchedCustomView(_ customView: CustomView)
}
