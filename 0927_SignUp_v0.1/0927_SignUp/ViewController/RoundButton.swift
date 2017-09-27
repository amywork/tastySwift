//
//  RoundButton.swift
//  0927_SignUp
//
//  Created by 김기윤 on 27/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
@IBDesignable // 이 클래스는 Interface Builder에서 디자인 할 수 있는 클래스입니다.

class RoundButton: UIButton {
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
}
