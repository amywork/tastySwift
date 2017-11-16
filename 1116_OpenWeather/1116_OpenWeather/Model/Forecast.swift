//
//  Forecast.swift
//  1116_URL
//
//  Created by 김기윤 on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  Forecast Data Model

import UIKit
import Foundation

// Forecast Model
internal struct Forecast {
    
    public var date: String
    public var weatherType: String
    public var maxTemp: String
    public var minTemp: String
    
    init?(weatherDict: Dictionary<String, AnyObject>) {
        
        guard let temp = weatherDict["main"] as? Dictionary<String, AnyObject> else { return nil }
        guard let min = temp["temp_min"] as? Double  else { return nil }
        let minTemp = round(min-273)
        self.minTemp = "\(minTemp)"
        
        guard let max = temp["temp_max"] as? Double  else { return nil }
        let maxTemp = round(max-273)
        self.maxTemp = "\(maxTemp)"
        
        guard let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] else { return nil }
        guard let main = weather[0]["main"] as? String else { return nil }
        self.weatherType = main
        
        guard let date = weatherDict["dt"] as? Double else { return nil }
        let convertedDate = Date(timeIntervalSince1970: date)
        self.date = convertedDate.dateToStr()
    }
    
}

extension Date {
    public func dateToStr() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 : HH시"
        return dateFormatter.string(from: self)
    } 
}


