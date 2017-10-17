//
//  Calculation.swift
//  1016_DataModel
//
//  Created by 김기윤 on 17/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

class Calculation {
    
    var seconds: Int = 0
    
    func hmsFrom(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        return (hours: seconds / 3600, minutes: (seconds % 3600) / 60, seconds: (seconds % 3600) % 60)
    }
    
    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    var finalStr: String {
        let hms = hmsFrom(seconds: seconds)
        let hour = getStringFrom(seconds: hms.hours)
        let minute = getStringFrom(seconds: hms.minutes)
        let second = getStringFrom(seconds: hms.seconds)
        return "\(hour):\(minute):\(second)"
    }
    
}
