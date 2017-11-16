//
//  RequestURL.swift
//  1116_URL
//
//  Created by Kimkeeyun on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  Request URL bundle.

import Foundation

public let baseURL = "https://api.openweathermap.org/data/2.5"
public let todayURI = "/weather"
public let forecastURI = "/forecast"
public let appidParam = "&appid=9eb78416466a2480d3da80192164b38c"
public let locationURL = baseURL + todayURI + "?lat=\(latitude)&lon=\(longitude)" + appidParam
public let locationForecastURL = baseURL + forecastURI + "?lat=\(latitude)&lon=\(longitude)" + appidParam

// MARK : - Location Based URL
public class Location {
    static var shared = Location()
    private init() {}
    var latitude: Double?
    var longitude: Double?
}

private var latitude: Double = Location.shared.latitude!
private var longitude: Double = Location.shared.longitude!

// MARK : - CityURL (RawValue for enum must be a literal)
public enum CityURL: String {
    case copenhagen = "https://api.openweathermap.org/data/2.5/weather?id=2618425&appid=9eb78416466a2480d3da80192164b38c"
    case melbourne = "https://api.openweathermap.org/data/2.5/weather?id=7839805&appid=9eb78416466a2480d3da80192164b38c"
    case portland = "https://api.openweathermap.org/data/2.5/weather?id=3578577&appid=9eb78416466a2480d3da80192164b38c"
}



/* TEST
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
*/

