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
    var totalGradePoint: Int = 0
    
  
    init(name: String, id: Int) {
        self.name = name
        self.studentID = id
    }
    
    // 수강 과목들을 모두 받아서 넣어주는 Method
    // setSubjects에는 배열을 넣을거야. 배열안에는 Subject 타입의 인스턴스들이 들어있어.
    func setSubjects(subjects:[Subject]) {
        self.subjects = subjects
        // 학생에게 과목을 입력하면서 토털 점수를 업뎃 할수도 있다.
        for sbj in subjects {
            totalScore += sbj.score
        }
    }

    // 수강 과목 하나를 받아서 넣어주는 Method
    func addSubject(subject: Subject) {
        self.subjects.append(subject)
        totalScore += subject.score
    }

}


