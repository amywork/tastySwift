//
//  EventData.swift
//  1016_DataModel
//
//  Created by 김기윤 on 16/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
struct EventData {
    
    var imageURL: String
    var eventName: String
    var eventPlace: String
    var startDate: Date
    var endDate: Date
    
    init?(dataDic: [String:Any]) {
        guard let imageURL = dataDic["imageURL"] as? String else { return nil }
        self.imageURL = imageURL
        
        guard let eventName = dataDic["eventName"] as? String else { return nil }
        self.eventName = eventName
        
        guard let eventPlace = dataDic["eventPlace"] as? String else { return nil }
        self.eventPlace = eventPlace
        
        // Date 처리
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        
        guard let startDateStr = dataDic["startDate"] as? String else { return nil }
        guard let startDate = formatter.date(from: startDateStr) else { return nil }
        self.startDate = startDate
        
        guard let endDateStr = dataDic["endDate"] as? String else { return nil }
        guard let endDate = formatter.date(from: endDateStr) else { return nil }
        self.endDate = endDate
    }
}
