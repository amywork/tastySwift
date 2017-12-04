//
//  CustomView.swift
//  DelegateSample
//
//  Created by youngmin joo on 2017. 10. 12..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    @IBOutlet var titleLB:UILabel!
    var delegate:CustomViewDelegate?
    
    @IBOutlet private  var btn:UIButton!
    
    
     func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents)
    {
        btn.addTarget(target, action: action, for: controlEvents)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    
    
    func changeText(newText:String)
    {
        titleLB.text = newText
    }
    
    @IBAction func btnAction(_ sender:UIButton)
    {
    
        delegate?.didSelectedCustomView(self)
    }
    
}


protocol CustomViewDelegate {
    func didSelectedCustomView(_ customView:CustomView)
}






