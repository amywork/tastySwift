//
//  calculatorModel.swift
//  CalculatorBrain
//
//  Created by 김기윤 on 20/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

class CalculatorModel {
    
    private enum OperatoinCase {
        case unary((Double) -> Double)
        case binary((Double,Double) -> Double)
        case equal
    }

    private var operDic: [String:OperatoinCase] = [
        "+": .binary({(num1, num2) -> Double in return num1 + num2}),
        "-": .binary({(num1, num2) -> Double in return num1 - num2}),
        "*": .binary({(num1, num2) -> Double in return num1 * num2}),
        "/": .binary({(num1, num2) -> Double in return num1 / num2}),
        "cos": .unary(cos),
        "±": .unary(sqrt),
        "√": .unary({(num1: Double) -> Double in return -num1}),
         "=": .equal
    ]

    
    func setNumber(displayNum: Double){
        waitingNum = displayNum
    }
    
    var waitingNum: Double?
    
    func perfomrOperation(mathSymbol: String) {
        if let operCase = operDic[mathSymbol] {
            switch operCase {
            case .unary(let function):
               function(waitingNum!)
            case .binary(let binaryFunction):
            if waitingNum != nil {
                let waitingBinary = WaitingBinary(firstNum: waitingNum!, waitingFunc: binaryFunction)
                }
            case .equal:
                break
            }
    	}
    }
    
    
//    private mutating func getResult() -> Double {
//        if waitingBinary != nil && waitingNum != nil {
//            result = waitingBinary.doBinaryOp(with: secondNum)
//        }
//        return result!
//    }
//    
//    
    private struct WaitingBinary {
        let firstNum: Double
        let waitingFunc: (Double,Double) -> Double
        
        func doBinaryOp(with secondNum: Double) -> Double {
            return waitingFunc(firstNum, secondNum)
        }
        
    }
    
    
    
    
}
