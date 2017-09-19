//
//  ViewController.swift
//  0919_calculatorBrain
//
//  Created by 김기윤 on 19/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var display: UILabel!
    
    var isUserTyping: Bool = false

    // When user touch Digits
    @IBAction func touchDigit(_ sender: UIButton) {
        
        guard let digit = sender.currentTitle else {return}
        if isUserTyping {
            let textCurrentlyInDisplay = display.text
            display.text = textCurrentlyInDisplay! + digit
        }else {
            display.text = digit
            isUserTyping = true
        }
    }
    
    // Computed properties
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display?.text = String(newValue)
        }
    }
    
    var brain: CalculatorBrain = CalculatorBrain()
    
    
    // 연산하기
    @IBAction func operation(_ sender: UIButton) {
        if isUserTyping {
            brain.setOperand(displayValue)
            isUserTyping = false
        }
        
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(mathSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }

}
