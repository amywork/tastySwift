//
//  TextField.swift
//  0927_SignUp
//
//  Created by Kimkeeyun on 27/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import UIKit
class TextFieldOption: UITextField {
    
    //똑같은데 코드로 쓸때는 꼭 요 init을 하고 아래와 같이 공통 속성을 넣어주면 된다
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //textField에 공통적으로 속성을 줄때 - 스토리보드에서 작성할때 요 init을 써줘야 한다.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 220.0 / 255.0, green: 219.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0).cgColor
    }
    
    //placeholder에 padding값 주기
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let paddingInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return UIEdgeInsetsInsetRect(self.bounds, paddingInset)
    }
    
    //textField에 padding값 주기
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let paddingInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return UIEdgeInsetsInsetRect(self.bounds, paddingInset)
    }
    
}
