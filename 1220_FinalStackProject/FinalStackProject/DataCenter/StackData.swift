//
//  StackData.swift
//  FinalStackProject
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//  User's Stack Data Modeling

import Foundation

enum PlanType: String {
    case yearly = "Every Year"
    case monthly  = "Every Month"
}

struct Stack {
    
    var title: String
    var planType: PlanType
    var date: Date // From yyMMdd
    var price: Float
    
    var dictionary: [String:String] {
        return ["title":self.title,
                "planType":self.planType.rawValue,
                "date":self.date.string(),
                "price":String(price)]
    }
    
    init(title: String, planType: PlanType, date: Date, price: Float) {
        self.title = title
        self.planType = planType
        self.date = date
        self.price = price
    }

    init?(with dic: [String:String]) {
        
        guard let title = dic["title"] else { return nil }
        self.title = title
        
        guard let planTypeString = dic["planType"]else { return nil }
        self.planType = PlanType(rawValue: planTypeString) ?? .monthly
        
        guard let dateString = dic["date"] else { return nil }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let date = formatter.date(from: dateString)
        self.date = date!
        
        guard let price = dic["price"] else { return nil }
        self.price = Float(price)!
        
    }

}
