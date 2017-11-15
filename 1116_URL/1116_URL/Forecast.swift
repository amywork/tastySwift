//
//  Forecast.swift
//  1116_URL
//
//  Created by 김기윤 on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
import Foundation

class Forecast {
    
    var date: String!
    var weatherType: String!
    var highTemp: String = ""
    var lowTemp: String = ""
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["main"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["temp_min"] as? Double {
                let temp = round(min-273)
                self.lowTemp = "\(temp)"
            }
            
            if let max = temp["temp_max"] as? Double {
                let temp = round(max-273)
                self.highTemp = "\(temp)"
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self.weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let convertedDate = Date(timeIntervalSince1970: date)
            self.date = convertedDate.dayOfTheWeek()
        }
        
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 HH시"
        return dateFormatter.string(from: self)
    } 
}


