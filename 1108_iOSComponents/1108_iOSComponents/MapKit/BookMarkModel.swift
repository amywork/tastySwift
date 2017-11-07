//
//  BookMarkModel.swift
//  1108_iOSComponents
//
//  Created by Kimkeeyun on 07/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import CoreLocation

class BookMarkModel {
    
    var locationCoordinate: CLLocationCoordinate2D
    var name: String
    
    func addBookMark(locationCoordinate: CLLocationCoordinate2D) {
        self.locationCoordinate = locationCoordinate
    }
    
    init(name: String, locationCoordinate: CLLocationCoordinate2D) {
        self.locationCoordinate = locationCoordinate
        self.name = name
    }
    
}
