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
    // 01. 라벨에 출력될 값을 결정할 displayText, 최초 nil
    var displayText: String? = nil
    
    // 02. 연산 기호를 저장해둘 operatorSign, 최초 nil
    var operatorSign: String? = nil
    
    // 03. 연산을 기다리는 값과 현재 인풋된 값을 구분하는 변수
    var firstNum: Int = 0
    var secondNum: Int = 0
    
    // 함수 정의
    // 01. 전시(displayLabel.text)될 숫자 만드는 함수
    @IBAction func btnNumberClick(numBtn: UIButton) {
        
        // 최초 실행의 경우는 입력된 숫자 스트링을 displayText에 대입
        if displayText == nil {
            displayText = (numBtn.titleLabel?.text)!
            // 최초 실행이 아닌 경우는 입력된 숫자 스트링을 displayText에 더하기 연산
        }else {
            displayText? += (numBtn.titleLabel?.text)!
        }
        // 라벨에는 displayText 전시
        displayLabel.text = displayText
    }
    
    
    // 02. 리셋(AC)버튼 클릭 시 모든것을 기본값으로 리셋해주는 함수
    @IBAction func btnResetClick(resetBtn: UIButton) {
        displayLabel.text = "0"
        displayText = nil
        firstNum = 0
        secondNum = 0
        operatorSign = nil
    }
    
    
    // 03. 연산 기호 눌렸을 때의 기능 정의
    /*
     3-1. displayText != nil일 때만 operation 함수 실행
     3-2. 눌려진 연산기호가 = 일 경우엔 최종 값을 출력.
     3-3. 일단 기존 기호를 가지고 연산한 뒤에 입력된 연산 기호로 change
     3-4. 연산 완료 후에는 displayText 초기화
     3-5. = 을 누르고 해당 값에 또 연산할 수 있음
     */
    @IBAction func operation(signBtn: UIButton) {
        if displayText != nil {
            Operation()
            operatorSign = signBtn.titleLabel!.text!
            displayText = nil
            if signBtn.titleLabel!.text! == "=" {
                displayLabel.text = String(firstNum)
            }
        }else {
            operatorSign = signBtn.titleLabel!.text!
        }
    }
    
    
    // 04. 함수 내에서 쓰일 내부 연산 함수 Operation
    /*
     4-1. operatorSign == nil, 최초 연산 시점, firstNum에 현재 displayText에 저장된 숫자를 대입
     4-2. firstNum에 값이 있다면, 연산을 기다리는 displayText가 존재한다는 뜻으로, 연산 기호에 맞춰 연산을 해준다.
     */
    
    private func Operation() {
        if operatorSign == nil {
            firstNum = Int(displayText!)!
        }else {
            secondNum = Int(displayText!)!
            if operatorSign == "+" {
                firstNum += secondNum
            }else if operatorSign == "-" {
                firstNum -= secondNum
            }else if operatorSign == "x" {
                firstNum *= secondNum
            }else if operatorSign == "÷" {
                firstNum /= secondNum
            }
            displayLabel.text = String(firstNum)
        }
    }
    
}
