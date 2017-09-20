//
//  calculatorModel.swift
//  CalculatorBrain
//
//  Created by 김기윤 on 20/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

class CalculatorModel {
    
    // 연산 타입 정의 : 단일, 이항, 등호
    // Associated Value 값에 클로저 대입
    private enum OperatoinCase {
        case unary((Double) -> Double)
        case binary((Double,Double) -> Double)
        case equal
    }

    
    // 연산 기호 : 연산 타입 딕셔너리 생성
    private var operDic: [String:OperatoinCase] = [
        "+": .binary({(num1, num2) -> Double in return num1 + num2}),
        "-": .binary({(num1, num2) -> Double in return num1 - num2}),
        "*": .binary({(num1, num2) -> Double in return num1 * num2}),
        "/": .binary({(num1, num2) -> Double in return num1 / num2}),
        "cos": .unary(cos),
        "√": .unary(sqrt),
        "±": .unary({(num1: Double) -> Double in return -num1}),
        "=": .equal
    ]

    
    // 연산을 기다리는 옵셔널 Double 변수 생성
    var waitingNum: Double?
    
    // 연산 기호 클릭 시 waitingNum에 디스플레이 값 대입
    func setNumber(displayNum: Double){
        waitingNum = displayNum
    }
    
    // 바이너리 연산을 위한 스트럭트 WaitingBinary의 인스턴스
    private var waitingBinary: WaitingBinary?
    
    // 연산 클릭시 연산 수행
    func perfomrOperation(mathSymbol: String) {
        if let operCase = operDic[mathSymbol] {
            switch operCase {
            case .unary(let function):
                if waitingNum != nil {
                    waitingNum = function(waitingNum!)
                }
            case .binary(let binaryFunction):
            if waitingNum != nil {
                getResult()
                waitingBinary = WaitingBinary(firstNum: waitingNum!, waitingFunc: binaryFunction)
                }
            case .equal:
                getResult()
            }
    	}
    }
    
    // 바이너리 연산 값 구하기
    private func getResult() {
        if waitingBinary != nil && waitingNum != nil {
            waitingNum = waitingBinary?.doBinaryOp(with: waitingNum!)
        }
    }
    
    // 바이너리 값 저장하고 있을 스트럭트
    private struct WaitingBinary {
        let firstNum: Double
        let waitingFunc: (Double,Double) -> Double
        
        func doBinaryOp(with secondNum: Double) -> Double {
            return waitingFunc(firstNum, secondNum)
        }
    }
    
    // 뷰콘트롤러에 넘겨줄 연산 완료된 값
    var returnValue: Double? {
        return waitingNum
    }
    
    
}
