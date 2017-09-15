//  ViewController.swift
//  Calculator
//  Created by 김기윤 on 11/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//  학점계산기의 MAIN 작업장 입니다.
//  변수명 및 주석 제대로 적기

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    
    // 변수 정의
    // 01. 라벨에 출력될 값을 결정할 displayText
    var displayText: String? = nil
    
    // 02. 연산 기호를 저장해둘 operatorSign
    var operatorSign: String? = nil
    
    // 03. 연산을 기다리는 값과 현재 인풋된 값을 구분하는 변수
    var firstNum: Int = 0
    var secondNum: Int = 0
    
    // 함수 정의
    // 01. 전시(displayLabel.text)될 숫자를 출력해주는 함수
    @IBAction func btnNumberClick(numBtn: UIButton) {
        
        // 전시된 숫자가 0이라는 것은 최초 실행의 경우이므로, 이때는 입력된 숫자 스트링 = displayText
        if displayLabel.text == "0" {
            displayText = (numBtn.titleLabel?.text)!
        // 그 외의 경우 입력된 숫자 스트링을 displayText에 계속 덧붙임
        }else {
            displayText += (numBtn.titleLabel!.text)!
        }
        // 최종으로 라벨에는 displayText 전시
        displayLabel.text = displayText
    }
    
    
    // 02. 리셋(AC)버튼 클릭 시 리셋해주는 함수
    @IBAction func btnResetClick(resetBtn: UIButton) {
        displayText = nil
        displayLabel.text = displayText
        firstNum = 0
        secondNum = 0
        operatorSign = nil
    }

    
    // 03. 연산 기호 눌렸을 때의 기능 정의
    /* displayText가 비어있지 않을 때만 prevOperation 함수 실행한다.
     눌려진 연산기호가 = 일 경우엔 최종 값을 출력하고 초기화한다.
 	*/
    @IBAction func operation(signBtn: UIButton) {
        if !(displayText.isEmpty) {
            Operation()
            operatorSign = signBtn.titleLabel!.text!
            displayText = ""
            if signBtn.titleLabel!.text! == "=" {
                displayLabel.text = String(firstNum)
                firstNum = 0
                secondNum = 0
                operatorSign = nil
            }
        }
    }

    
    // 04. 함수 내에서 쓰일 내부 연산자 prevOperation
    /* 
     4-1. prevNum=0 일 경우는, 최초 연산 시점이기 때문에, prevNum에 현재 displayText에 저장된 숫자를 집어넣는다.
     4-2. prevNum에 값이 있다면, 연산을 기다리는 displayText가 존재한다는 뜻으로, 연산 기호에 맞추어 연산을 해준다.
     */
    private func Operation() {
        if (operatorSign?.isEmpty)! {
            firstNum = Int(displayText)!
        }else {
            secondNum = Int(displayText)!
            if operatorSign == "+" {
                firstNum += secondNum
                displayLabel.text = String(firstNum)
            }else if operatorSign == "-" {
                firstNum -= secondNum
                displayLabel.text = String(firstNum)
            }else if operatorSign == "x" {
                firstNum *= secondNum
                displayLabel.text = String(firstNum)
            }else if operatorSign == "÷" {
                firstNum /= secondNum
                displayLabel.text = String(firstNum)
            }
        }
    }
    
    




}
