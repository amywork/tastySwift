//  CreditCalculation.swift
//  Calculator
//  Created by 김기윤 on 12/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//  객체지향으로 구성하기위해, 연산하는 애들만 모아놓은 함수를 하나 또 만들겠다.


import Foundation

class CreditCalculation {
    
    // 01. 학생 객체를 파라메터로 받아서 평균을 구해주는 함수
    func studentScoreAvg(student: Student) -> Int {
        let avgScore = avgSubjectScores(subjects: student.subjects)
        student.totalScore = avgScore
        return student.totalScore
    }
    
    // 02. Subject 객체들이 담긴 배열의 Score들을 모두 더해서 평균내주는 함수
    func avgSubjectScores(subjects:[Subject]) -> Int {
        var totalScore: Int = 0
        for sbj in subjects {
            totalScore += sbj.score
        }
        let avgScore: Int = totalScore / subjects.count
        return avgScore
    }
    
    // 03. Subject 객체들이 담긴 배열의 Score들을 모두 더해서 합만 구해주는 함수
    func addAllSubjectSocres(subjects: [Subject]) -> Int {
        var totalScore: Int = 0
        for sbj in subjects {
            totalScore += sbj.score
        }
        return totalScore
    }
    
    // 04. 강사님과 함께 작성하는 코드 (평균 계산 함수 한방에!)
    func avgCalculation(student: Student) -> Double {
        var totalScore: Int = 0
        let subjects = student.subjects
        for sbj in subjects {
            totalScore += sbj.score
        }
        return Double(totalScore)/Double(subjects.count)
    }
    
    
}
