//
//  ViewController.swift
//  StudentCredit
//
//  Created by 김기윤 on 14/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let math = Subject(name: "Math")
        let english = Subject(name: "English")
        let computer = Subject(name: "Computer")
        let science = Subject(name: "Science")
        let economy = Subject(name: "Economy")
        
        math.setScore(score: 90)
        english.setScore(score: 93)
        computer.setScore(score: 95)
        science.setScore(score: 89)
        economy.setScore(score: 88)
        
        let steve: Student = Student(name: "Steve", id: 2011111050)
        steve.setSubjects(subjects: [math, english, computer, science, economy])
        
        let cal = CreditCalculation()
        steve.average = cal.avgCalculation(student: steve)
        
        print(steve.totalGrade)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

