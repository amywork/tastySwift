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
    var numbers: [Int] = []
    var signs: Int = 1
    var tmp: Int = 0
    var inputValue: Bool = false
    
    
    // 숫자 입력시 displayText가 출력됨
    @IBAction func btnNumberClick(btn: UIButton) {
        
        if displayLabel.text == "0" {
            displayText = (btn.titleLabel?.text)!
        }else {
           displayText += (btn.titleLabel!.text)!
        }
        
        displayLabel.text = displayText
    }


    // 중복되는 부분 함수로 분리함
    func calculate() {
        numbers.append(Int(displayText)!)
        if signs == 1 {
            tmp += numbers.last!
        }else if signs == 2 {
            tmp -= numbers.last!
        }else if signs == 3 {
            tmp *= numbers.last!
        }else if signs == 4 {
            tmp /= numbers.last!
        }
        displayLabel.text = String(tmp)
    }
    
    
    // 연산 기호 클릭시
    @IBAction func operation(sign: UIButton) {
        
        if displayText == "" {

        }else {
            
            if sign.titleLabel!.text == "+" {
                
                if numbers.isEmpty {
                    numbers.append(Int(displayText)!)
                    tmp = numbers.last!
                    signs = 1
                }else {
                    calculate()
                }
                
                signs = 1
                displayText = ""
                
            }else if sign.titleLabel!.text == "-" {
                
                if numbers.isEmpty {
                    numbers.append(Int(displayText)!)
                    tmp = numbers.last!
                    signs = 2
                }else {
                    calculate()
                }
                
                displayLabel.text = String(tmp)
                signs = 2
                displayText = ""
                
            }else if sign.titleLabel!.text == "x" {
                
                if numbers.isEmpty {
                    numbers.append(Int(displayText)!)
                    tmp = numbers.last!
                    signs = 3
                }else {
                    calculate()
                }
                
                displayLabel.text = String(tmp)
                signs = 3
                displayText = ""
                
            }else if sign.titleLabel!.text == "÷" {
                
                if numbers.isEmpty {
                    numbers.append(Int(displayText)!)
                    tmp = numbers.last!
                    signs = 4
                }else {
                    calculate()
                }
                
                displayLabel.text = String(tmp)
                signs = 4
                displayText = ""
                
            }else if sign.titleLabel!.text == "=" {
                
                calculate()
                displayLabel.text = String(tmp)
                numbers = []
                tmp = 0
                displayText = ""
            }
            
        }
        
    }
    
    
    @IBAction func btnResetClick(btn: UIButton) {
        displayText = "0"
        displayLabel.text = displayText
    }
    
}





