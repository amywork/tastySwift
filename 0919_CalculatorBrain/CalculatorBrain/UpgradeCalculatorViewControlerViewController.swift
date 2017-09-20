//
//  UpgradeCalculatorViewControlerViewController.swift
//  CalculatorBrain
//
//  Created by 김기윤 on 20/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class UpgradeCalculatorViewControler: UIViewController {

    //MARK: - UI Property
    @IBOutlet weak var displayLB: UILabel!

    //MARK: - IBAction
    //숫자 입력받는 거 OK
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
        isTyping = false
        displayLB.text = "0"
    }
    
    // 숫자 임시값
    var displayValue: Double {
        get {
            return Double(displayLB.text!)!
        }
        set {
        	displayLB.text! = String(newValue)
        }
    }
    
    // 연산 모델 호출!
    var calModel = CalculatorModel()

    // operation 버튼을 눌렀을 때 생기는 일
    @IBAction func operation(_ sender: UIButton) {
        isTyping = false
        calModel.setNumber(displayNum: displayValue)
        
        guard let symbol = sender.currentTitle else { return }
        calModel.perfomrOperation(mathSymbol: symbol)
    }

}
