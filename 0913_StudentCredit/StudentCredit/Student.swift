//
//  Student.swift
//  Calculator
//
//  Created by 김기윤 on 12/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

class Student {
    var name: String
    var studentID: Int
    var subjects: [Subject] = []
    
    var totalScore: Int = 0
    var average: Double = 0
    
    var totalGrade: String = "F"
    var totalGradePoint: Double = 0.0
    
    
    init(name: String, id: Int) {
        self.name = name
        self.studentID = id
    }
    
    // 수강 과목들을 모두 받아서 넣어주는 Method
    // setSubjects에는 배열을 넣을거야. 배열안에는 Subject 타입의 인스턴스들이 들어있어.
    func setSubjects(subjects:[Subject]) {
        self.subjects = subjects
        // 학생이 듣는 과목을 SET하면, 동시에 total Score를 업데이트 한다.
        for sbj in subjects {
            totalScore += sbj.score
        }
        // 동시에 GradePoint의 합과 Grade를 업데이트 한다.
        getTotalGradePoints()
        gradepointToGrade(totalGradePoint)
    }
    
    
    func getTotalGradePoints() {
        var totalPoint: Double = 0.0
        for sbj in self.subjects {
            totalPoint += sbj.gradePoint
        }
        totalGradePoint = totalPoint/Double(subjects.count)
    }
    
    
    func gradepointToGrade(_: Double) -> String {
        switch totalGradePoint {
        case 4.0...4.5:
            totalGrade = "A+"
        case 3.5..<4.0:
            totalGrade = "A"
        case 3.0..<3.5:
            totalGrade = "B+"
        case 2.5..<3.0:
            totalGrade = "B"
        case 2.0..<2.5:
            totalGrade = "C+"
        case 1.5..<2.0:
            totalGrade = "C"
        default:
            totalGrade = "F"
        }
        return totalGrade
    }
}



// 수강 과목 하나를 받아서 넣어주는 Method
//func addSubject(subject: Subject) {
//    self.subjects.append(subject)
//    totalScore += subject.score
//}


