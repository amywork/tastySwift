//
//  calculatorBrain.swift
//  0919_calculatorBrain
//
//  Created by 김기윤 on 19/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//  Stanford CS193P 2017

import Foundation

func changeSign(_ operand: Double) -> Double {
    return -operand
}

struct CalculatorBrain {
    
    // initially accumulator is not set
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double,Double) -> Double)
        case equals
    }
    
    
    private var operations: Dictionary<String,Operation> =
    [
        "ㅠ" : Operation.constant(Double.pi),
        "√" : Operation.unary(sqrt),
        "cos" : Operation.unary(cos),
        "±" : Operation.unary(changeSign),
        "+" : Operation.binary({$0 + $1}),
        "-" : Operation.binary({$0 - $1}),
        "x" : Operation.binary({$0 * $1}),
        "÷" : Operation.binary({$0 / $1}),
        "=" : Operation.equals
    ]
    
    
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unary(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binary(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, first: accumulator!)
                    accumulator = nil
                }
            case .equals:
                perfomPendingBinaryOperation()
            }
        }
    }
    
    private mutating func perfomPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let first: Double
        
        func perform(with second: Double) -> Double {
            return function(first, second)
        }
    }
    
    
    
    
    // Stuct is Value type, we have to tell them we are changing value.
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
