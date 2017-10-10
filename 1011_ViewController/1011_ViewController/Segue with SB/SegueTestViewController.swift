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
    @IBOutlet weak var textField: UITextField!
    
    // 스위치 액션에 대한 Bool 값
    @IBAction func ableToNext(_ sender: UISwitch) {
        isAbleToNext = sender.isOn
    }
    
    // Segue를 실행해야할지 말지에 대한 결정
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "nextDestination" {
            return isAbleToNext
        }else {
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextDestination" {
            let destionationVC = segue.destination as? DestinationViewController
            let nextStr = textField.text ?? "nothing to send"
            destionationVC?.takeMessage(nextStr) // String 전달
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.placeholder = "Type Something :)"
        // Do any additional setup after loading the view.
    }
    
}
