//
//  Extensions.swift
//  FinalStackProject
//
//  Created by Kimkeeyun on 05/12/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

extension Date {
    
    public func string() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = mmdd
        return formatter.string(from: self)
    }
    
}
