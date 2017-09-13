//  ViewController.swift
//  Calculator
//  Created by 김기윤 on 11/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//  학점계산기의 MAIN 작업장 입니다.

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // super = 부모의 속성
        
        let math = Subject(name: "Math")
        let english = Subject(name: "English")
        let computer = Subject(name: "Computer")
        math.setScore(score: 90)
        english.setScore(score: 93)
        computer.setScore(score: 95)
        
        let steve: Student = Student(name: "Steve", id: 2011111050)
        steve.setSubjects(subjects: [math, english, computer])

        // Steve 학생의 average에 값 넣어주기
        let cal = CreditCalculation()
        steve.average = cal.avgCalculation(student: steve)
    }
}


