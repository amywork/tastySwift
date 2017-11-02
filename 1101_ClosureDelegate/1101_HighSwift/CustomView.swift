//
//  CustomView.swift
//  1101_HighSwift
//
//  Created by 김기윤 on 01/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    var delegate: CustomViewDelegate?
    var btnActionClosure:((CustomView)->Void)?
    
    @IBOutlet weak var titleLable:UILabel!
    @IBOutlet weak var textField:UITextField!
    
    @IBAction func btnAction(_ sender: UIButton) {
        delegate?.didSelectedView(self)
        btnActionClosure!(self)
    }
    
    func didSelectedClosure(closure:@escaping (CustomView)->Void) {
        btnActionClosure = closure
    }
    
    
    func animation(duration: Int, animation: () -> Void, completion: (() -> Void)?) {
        for _ in 0...duration {
            animation()
        }
        completion?()
    }

}

protocol CustomViewDelegate {
    func didSelectedView(_ view: CustomView)
}
