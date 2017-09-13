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
    
    init(name: String) {
        self.name = name
    } // instance를 생성할 때, 무조건 name 초기화
    
    
    func setScore(score: Int) {
        self.score = score
        changeGrade()
        gradeToGradepoint()
    } // method 함수 구현
    
    
    func changeGrade() {
        if score > 0 && score <= 100 {
            if score >= 95 {
                grade = "A+"
            }else if score >= 90 {
                grade = "A"
            }else if score >= 85 {
                grade = "B+"
            }else if score >= 80 {
                grade = "B"
            }else if score >= 75 {
                grade = "C+"
            }else if score >= 70 {
                grade = "C"
            }
        }
    }
    
    func gradeToGradepoint() {
        if grade == "A+" {
            gradePoint = 4.0
        }else if grade == "A" {
            gradePoint = 3.5
        }else if grade == "B+" {
            gradePoint = 3.0
        }else if grade == "B" {
            gradePoint = 2.5
        }else if grade == "C+" {
            gradePoint = 2.0
        }else if grade == "C" {
            gradePoint = 1.5
        }
    }
    
}







