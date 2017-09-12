//
//  Subject.swift
//  Calculator
//
//  Created by 김기윤 on 12/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

class Subject {
    var name: String
    var score: Int = 0
    var grade: String = "F"
    var gradePoint: Double = 0.0
    var credit: Int = 1
    
    init(name: String) {
        self.name = name
    } // instance를 생성할 때, 무조건 name이 초기화 됨

    func setScore(score: Int) {
        self.score = score
    } // method 함수 구현
}
