//
//  ViewController.swift
//  DelegateSample
//
//  Created by youngmin joo on 2017. 10. 12..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CustomViewDelegate {

    @IBOutlet var newView:CustomView!
    @IBOutlet var newLb:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newView.changeText(newText: "뷰컨에서 바꿈")
        newView.delegate = self
        
//        newView.addTarget(self, action: #selecetor, for: <#T##UIControlEvents#>)
    }

    func didSelectedCustomView(_ customView: CustomView) {
        //customView가 클릭 됐다!
        newLb.text = "커스텀뷰 클릭됐으!"
        
        customView.titleLB.text = "델리게이트에서 바뀜"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

