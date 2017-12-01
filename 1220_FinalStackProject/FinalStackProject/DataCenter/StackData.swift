//
//  StackData.swift
//  FinalStackProject
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//  User's Stack Data Modeling

import Foundation

enum PlanType: String {
    case year
    case month
}

struct StackData {
    
    var name: String
    var plan: PlanType
    var memo: String?
    var payDay: Date // From yyMMdd
    
    
    var stackDataDic: [String:Any] {
        return ["name":self.name,
                "plan":self.plan,
                "memo":self.memo ?? "",
                "payDay":self.payDay
        ]
    }
    
    init(name: String, planStr: String, payDay: Date) {
        self.name = name
        self.plan = PlanType(rawValue: planStr) ?? .month
        self.payDay = payDay
    }
    
    init(name: String, planStr: String, payDay: Date, memo: String) {
        self.name = name
        self.plan = PlanType(rawValue: planStr) ?? .month
        self.payDay = payDay
        self.memo = memo
    }
    
    init?(with dataDic: [String:Any]) {
        
        guard let name = dataDic["name"] as? String else { return nil }
        self.name = name
        
        guard let planStr = dataDic["plan"] as? String else { return nil }
        self.plan = PlanType(rawValue: planStr) ?? .month
        
        let memo = dataDic["memo"] as? String
        self.memo = memo
        
        guard let payDayStr = dataDic["payDay"] as? String else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        let payDay = formatter.date(from: payDayStr)
        self.payDay = payDay!
        
    }

}
