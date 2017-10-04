//
//  DateModel.swift
//  1003_DailyTable
//
//  Created by Kimkeeyun on 04/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit
import Foundation

class DateModel {

    var title: String
    var detail: String
    
    var color: UIColor?
    
    init?(title: String, detail: String, color: UIColor) {
        self.title = title
        self.detail = detail
        self.color = color
    }

}
