//
//  TodayWeather.swift
//  1116_URL
//
//  Created by Kimkeeyun on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  TodayWeather Data Model

import Foundation
import UIKit

internal struct TodayWeather {
 
    public var cityName: String
    public var weatherType: String
    public var temp: String
    
    init?(dic: Dictionary<String, AnyObject>) {
        guard let name = dic["name"] as? String else { return nil }
        self.cityName = name
        
        guard let weather = dic["weather"] as? [Dictionary<String, AnyObject>] else { return nil }
        guard let main = weather[0]["main"] as? String else { return nil }
        self.weatherType = main.capitalized
    
        guard let mainTemp = dic["main"] as? Dictionary<String, AnyObject> else { return nil }
        guard let currentTemp = mainTemp["temp"] as? Double else { return nil }
        let convertedTemp = round(currentTemp-273) 
        self.temp = "\(convertedTemp)"
    }
    
}
