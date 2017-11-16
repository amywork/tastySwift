//
//  RequestURL.swift
//  1116_URL
//
//  Created by Kimkeeyun on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import CoreLocation

// MARK : - CityURL
public enum CityURL: String {
    case copenhagen = "https://api.openweathermap.org/data/2.5/weather?id=2618425&appid=9eb78416466a2480d3da80192164b38c"
    case melbourne = "https://api.openweathermap.org/data/2.5/weather?id=7839805&appid=9eb78416466a2480d3da80192164b38c"
    case portland = "https://api.openweathermap.org/data/2.5/weather?id=3578577&appid=9eb78416466a2480d3da80192164b38c"
}

// MARK : - Location URL
public class Location {
    static var shared = Location()
    private init() {}
    var latitude: Double?
    var longitude: Double?
}

public var latitude: Double {
    if let lat = Location.shared.latitude {
        return lat
    }else {
        return 37.7739
    }
}

public var longitude: Double {
    if let lon = Location.shared.longitude {
        return lon
    }else {
        return -122.43129
    }
}

public let locationURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=9eb78416466a2480d3da80192164b38c"

public let locationForecastURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=9eb78416466a2480d3da80192164b38c"





