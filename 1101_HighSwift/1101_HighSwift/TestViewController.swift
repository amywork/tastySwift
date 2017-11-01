//
//  TestViewController.swift
//  1101_HighSwift
//
//  Created by 김기윤 on 01/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, CustomViewDelegate {

    @IBOutlet weak var customView: CustomView!
    @IBOutlet weak var textLable: UILabel!
    
    @IBAction func trickingAnimation(_ sender: UIButton) {
        self.customView.animation(duration: 2, animation: animation, completion: animation2)
    }

    func animation() {
        self.customView.center.x += 60
    }
    
    func animation2() {
        self.customView.center.y -= 60
    }
    
    let numbers = 1...10
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        /*Array Method - map, filter, reduce*/
        let result = numbers.filter { $0 % 2 == 0 }.reduce(50) { $0 + $1 }
        print(result)
        
        customView.delegate = self
        customView.didSelectedClosure { view in
            self.textLable.text = view.textField.text
        }
        
    }
    
    func didSelectedView(_ view: CustomView) {
        self.textLable.text = view.titleLable.text
    }
   
}
