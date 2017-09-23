//
//  UpgradeCalculatorViewControlerViewController.swift
//  CalculatorBrain
//
//  Created by 김기윤 on 20/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//  Unary Function 해결하기

import UIKit
class UpgradeCalculatorViewControler: UIViewController {

    //MARK: - UI Property
    @IBOutlet weak var displayLB: UILabel!

    //MARK: - IBAction
    //숫자 입력받기 OK
    var isTyping: Bool = false
    @IBAction func digit(_ sender: UIButton) {
        let currentDigit = sender.currentTitle!
        if isTyping {
            let textCurrentlyInDisplay = displayLB!.text!
            displayLB!.text = textCurrentlyInDisplay + currentDigit
        }else {
            displayLB!.text = currentDigit
            isTyping = true
        }
    }
    
    // 리셋
    @IBAction func resetHandler(_ sender: UIButton) {
        displayValue = 0.0
        isTyping = false
        calModel.setNumber(displayNum: displayValue)
        calModel.operand = nil
    }
    
    // 전시된 값을 get 하거나 set하는 displayValue
    var displayValue: Double {
        get {
            return Double(displayLB.text!)!
        }
        set {
        	displayLB.text! = String(newValue)
        }
    }
    
    // operation
    var calModel = CalculatorModel()
    @IBAction func operation(_ sender: UIButton) {
        if isTyping { // check
            calModel.setNumber(displayNum: displayValue)
            isTyping = false
        }
        
        guard let symbol = sender.currentTitle else { return }
        calModel.perfomrOperation(mathSymbol: symbol)
        if symbol == "=" {
            displayValue = calModel.returnValue!
        }else {
            displayValue = calModel.operand!
        }
    }
}
