//
//  calculatorModel.swift
//  CalculatorBrain
//
//  Created by 김기윤 on 20/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

class CalculatorModel {
    
    // 연산 타입 정의 : 단일, 이항, 등호 연산
    // Associated Value = closure
    private enum OperatoinCase {
        case unary((Double) -> Double)
        case binary((Double,Double) -> Double)
        case equal
    }

    // 연산 딕셔너리
    private var operDic: [String:OperatoinCase] = [
        "+": .binary({$0 + $1}),
        "-": .binary({$0 - $1}),
        "*": .binary({$0 * $1}),
        "/": .binary({$0 / $1}),
        "√": .unary(sqrt),
        "±": .unary({ val in return -val }),
        "=": .equal
    ]

    // 연산을 기다리는 옵셔널 Double
    var firstNum: Double?
    var middleNum: Double?
    func setNumber(displayNum: Double){
        firstNum = displayNum
    }
    
    // Binary 연산을 저장하고 있을 Struct
    private struct WaitingBinary {
        let waitingNum: Double
        let waitingFunc: (Double,Double) -> Double
        func doBinaryOp(with value: Double) -> Double {
            return waitingFunc(waitingNum, value)
        }
    }
    
    // 바이너리 연산을 위한 스트럭트 WaitingBinary의 인스턴스
    private var waitingBinary: WaitingBinary?
    
    func perfomrOperation(with mathSymbol: String) {
        if let operationCase = operDic[mathSymbol] {
            switch operationCase {
                
            case .unary(let unaryFunc):
                if firstNum != nil && middleNum == nil {
                    middleNum = unaryFunc(firstNum!)
                }else if middleNum != nil {
                    middleNum = unaryFunc(middleNum!)
                }
                
            case .binary(let binaryFunc):
                if firstNum != nil && middleNum == nil {
                    middleNum = firstNum!
                    waitingBinary = WaitingBinary(waitingNum: middleNum!, waitingFunc: binaryFunc)
                }else if firstNum != nil && middleNum != nil && waitingBinary != nil {
                    middleNum! = waitingBinary!.doBinaryOp(with: firstNum!)
                    waitingBinary = WaitingBinary(waitingNum: middleNum!, waitingFunc: binaryFunc)
                }else if middleNum != nil && firstNum == nil {
                    waitingBinary = WaitingBinary(waitingNum: middleNum!, waitingFunc: binaryFunc)
                }else if firstNum != nil && middleNum != nil && waitingBinary == nil {
                    waitingBinary = WaitingBinary(waitingNum: middleNum!, waitingFunc: binaryFunc)
                }
                firstNum = nil
                
            case .equal:
                getResult()
                firstNum = nil
            }
        }
    }

    // Equal 연산
    private func getResult() {
        if waitingBinary != nil && firstNum != nil {
            middleNum = waitingBinary!.doBinaryOp(with: firstNum!)
        }
        
    }
    
}
