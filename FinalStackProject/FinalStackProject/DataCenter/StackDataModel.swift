//
//  StackData.swift
//  FinalStackProject
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

enum Plan: String {
    case year
    case month
}

struct StackDataModel {
    
    var stackName: String
    var stackDescription: String
    var plan: Plan
    
    var stackDataDic: [String:String] {
        return ["Nickname":self.stackName,
                "MyProfileDescription":self.stackDescription,
                "StatusDescription":self.plan.rawValue,
        ]
    }
    
    init?(with dataDic: [String:String]) {
        
        guard let name = dataDic["Nickname"] else { return nil }
        self.stackName = name
        
    }

}
