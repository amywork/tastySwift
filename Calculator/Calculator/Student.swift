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
    
    var totalGrade: String = "F"
    var totalGradePoint: Int = 0
  
    init(name: String, id: Int) {
        self.name = name
        self.studentID = id
    }
    
    // 수강 과목들을 모두 받아서 넣어주는 Method
    func setSubjects(subjects:[Subject]) {
        self.subjects = subjects
    }
    
    // 질문: 위에서, Student 클래스에서, Subject 클래스를 상속받은 것인가요?
    // 수강 과목 하나를 받아서 넣어주는 Method
    func addSubject(subject: Subject) {
        self.subjects.append(subject)
    }
}


