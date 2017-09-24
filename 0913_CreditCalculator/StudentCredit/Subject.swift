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
    
    // instance를 생성할 때, 무조건 name 초기화
    init(name: String) {
        self.name = name
    }
    
    // method 함수 구현
    func setScore(score: Int) {
        self.score = score
        scoreToGrade(score)
        gradeToGradepoint(grade: grade)
    }
    
    
    func scoreToGrade(_: Int) -> String {
        switch score {
        case 95...100:
			grade = "A+"
        case 90..<95:
            grade = "A"
        case 85..<90:
            grade = "B+"
        case 80..<85:
            grade = "B"
        case 75..<80:
        	grade = "C+"
        case 70..<75:
        	grade = "C"
        default:
            grade = "F"
		}
        return grade
    }
    
    
    func gradeToGradepoint(grade: String) -> Double {
        switch grade {
        case "A+":
            gradePoint = 4.0
        case "A":
            gradePoint = 3.5
        case "B+":
            gradePoint = 3.0
        case "B":
            gradePoint = 2.5
        case "C+":
            gradePoint = 2.0
        case "C":
            gradePoint = 1.5
        default:
            gradePoint = 0.0
        }
        return gradePoint
    }
    
}







