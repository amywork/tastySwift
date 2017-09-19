//
//  calculatorBrain.swift
//  0919_calculatorBrain
//
//  Created by 김기윤 on 19/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double
    
    func performOperation(_ symbol: String) {
        
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    // Computed properties
    var result: Double {
        get {
            
        }
    }
}
