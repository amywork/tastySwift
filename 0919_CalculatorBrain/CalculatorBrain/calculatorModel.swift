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
        "+": .binary({$0 + $1}),
        "-": .binary({$0 - $1}),
        "*": .binary({$0 * $1}),
        "/": .binary({$0 / $1}), //({(num1, num2) -> Double in return num1 / num2}),
        "√": .unary(sqrt),
        "±": .unary({(num1: Double) -> Double in return -num1}),
        "=": .equal
    ]

    // 연산을 기다리는 옵셔널 Double 변수 생성
    var leftNumber: Double? 
    
    // 연산 기호 클릭 시 leftNum에 디스플레이 값 대입
    func setNumber(displayNum: Double){
        leftNumber = displayNum
    }
    
    // 바이너리 연산을 위한 스트럭트 WaitingBinary의 인스턴스
    private var waitingBinary: WaitingBinary?
    
    // 연산 클릭시 연산 수행
    var operand: Double?
    
    func perfomrOperation(mathSymbol: String) {
        if let operationCase = operDic[mathSymbol] {
            switch operationCase {
                
            case .unary(let function):
                if leftNumber != nil && operand == nil {
                    operand = function(leftNumber!)
                }else if operand != nil { // leftNumber != nil &&
                    operand = function(operand!)
                }
                
            case .binary(let binaryFunc):
                if leftNumber != nil && operand == nil {
                    operand = leftNumber!
                    waitingBinary = WaitingBinary(firstNum: operand!, waitingFunc: binaryFunc)
                }else if leftNumber != nil && operand != nil && waitingBinary != nil {
                    operand! = waitingBinary!.doBinaryOp(with: leftNumber!)
                    waitingBinary = WaitingBinary(firstNum: operand!, waitingFunc: binaryFunc)
                }else if operand != nil && leftNumber == nil {
                    waitingBinary = WaitingBinary(firstNum: operand!, waitingFunc: binaryFunc)
                }else if leftNumber != nil && operand != nil && waitingBinary == nil {
                    waitingBinary = WaitingBinary(firstNum: operand!, waitingFunc: binaryFunc)
                }
                leftNumber = nil
                
            case .equal:
                getResult()
                operand = returnValue
                leftNumber = nil
            }
        }
    }
    
    // Binary 연산을 저장하고 있을 Struct
    private struct WaitingBinary {
        let firstNum: Double
        let waitingFunc: (Double,Double) -> Double
        func doBinaryOp(with secondNum: Double) -> Double {
            return waitingFunc(firstNum, secondNum)
        }
    }

    // Binary 연산의 결과값 구하기 (Equal 연산)
    var returnValue: Double? // ViewController에 넘겨줄 연산 완료 값
    private func getResult() {
        if waitingBinary != nil && leftNumber != nil {
            returnValue = waitingBinary!.doBinaryOp(with: leftNumber!)
        }
    }
    
}
