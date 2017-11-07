//
//  Location.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 07/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    var latitude: Double!
    var longitude: Double!
}
