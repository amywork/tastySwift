//
//  UpgradeCalculatorViewControlerViewController.swift
//  CalculatorBrain
//
//  Created by 김기윤 on 20/09/2017.
//  Copyright © 2017 younari. All rights reserved.

import UIKit
class UpgradeCalculatorViewControler: UIViewController {

    override func viewDidLoad() {
        self.displayLB.text = "calculator"
    }
    
    //MARK: - UI Property
    @IBOutlet weak var displayLB: UILabel!

    //MARK: - IBAction
    //숫자 입력
    var isTyping: Bool = false
  
    @IBAction func digitBtnHandler(_ sender: UIButton) {
        let currentDigit = sender.currentTitle!
        if isTyping {
            let textCurrentlyInDisplay = displayLB.text
            displayLB!.text = textCurrentlyInDisplay! + currentDigit
        }else {
            displayLB!.text = currentDigit
            isTyping = true
        }
    }
    
    // 리셋
    @IBAction func resetHandler(_ sender: UIButton) {
        displayLB.text = "calculator"
        isTyping = false
        calModel.middleNum = nil
        calModel.firstNum = nil
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
    
    @IBAction func operationBtnHandler(_ sender: UIButton) {
        if isTyping {
            calModel.setNumber(displayNum: displayValue)
            isTyping = false
            guard let symbol = sender.currentTitle else { return }
            calModel.perfomrOperation(with: symbol)
            displayValue = calModel.middleNum!
        }else if isTyping == false && calModel.middleNum != nil {
            calModel.setNumber(displayNum: displayValue)
            guard let symbol = sender.currentTitle else { return }
            calModel.perfomrOperation(with: symbol)
            displayValue = calModel.middleNum!
        }
    }
}
