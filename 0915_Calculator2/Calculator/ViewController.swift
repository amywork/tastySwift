//  ViewController.swift
//  Calculator
//  Created by 김기윤 on 11/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//  학점계산기의 MAIN 작업장 입니다.
import UIKit
class ViewController: UIViewController {
    
    @IBOutlet var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    
    var displayText: String = "0"
    var prevSign: String = "+"
    
    var prev: Int = 0
    var current: Int = 0
    
    // 전시(displayLabel.text)될 숫자 및 displayText 정의
    @IBAction func btnNumberClick(btn: UIButton) {
        if displayLabel.text == "0" {
            displayText = (btn.titleLabel?.text)!
        }else {
            displayText += (btn.titleLabel!.text)!
        }
        displayLabel.text = displayText
    }
    
    // 리셋 기능 정의
    @IBAction func btnResetClick(btn: UIButton) {
        displayText = "0"
        displayLabel.text = displayText
        prev = 0
        current = 0
    }
    
    // 연산 기능 정의
    @IBAction func operation(sign: UIButton) {
        if displayText != "" {
            if sign.titleLabel!.text! == "+" {
                prevOperation()
            }else if sign.titleLabel!.text! == "-" {
                prevOperation()
            }else if sign.titleLabel!.text! == "x" {
                prevOperation()
            }else if sign.titleLabel!.text! == "÷" {
                prevOperation()
            }else if sign.titleLabel!.text! == "=" {
                prevOperation()
                displayLabel.text = String(prev)
                prev = 0
            }
            prevSign = sign.titleLabel!.text!
            displayText = ""
        }
    }
    
    func prevOperation() {
        if prev == 0 {
            prev = Int(displayText)!
        }else {
            current = Int(displayText)!
            if prevSign == "+" {
                prev += current
                displayLabel.text = String(prev)
            }else if prevSign == "-" {
                prev -= current
                displayLabel.text = String(prev)
            }else if prevSign == "x" {
                prev *= current
                displayLabel.text = String(prev)
            }else if prevSign == "÷" {
                prev /= current
                displayLabel.text = String(prev)
            }
        }
    }
}
