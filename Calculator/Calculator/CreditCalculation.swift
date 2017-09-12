//
//  CreditCalculation.swift
//  Calculator
//
//  Created by 김기윤 on 12/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

class CreditCalculation {
    
    func scoreAvgCal(student: Student) -> Int {
        let avgScore = avgSubjectScores(subjects: student.subjects)
        student.totalScore = avgScore
        return student.totalScore
    }
    
    func avgSubjectScores(subjects:[Subject]) -> Int {
        
        var totalScore: Int = 0
        for sbj in subjects {
            totalScore += sbj.score
        }
        
        totalScore /= subjects.count
        return totalScore
    }
    
}
