//
//  SegueTestViewController.swift
//  1011_ViewController
//
//  Created by 김기윤 on 10/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class SegueTestViewController: UIViewController {

    var isAbleToNext: Bool = true
    @IBAction func ableToNext(_ sender: UISwitch) {
        isAbleToNext = sender.isOn
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "nextDestination" {
            return isAbleToNext
        }else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
