//
//  ViewController.swift
//  Calculator
//
//  Created by 김기윤 on 11/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        
        
        var math = Subject(name: "Math", score: 94)
        var english = Subject(name: "English", score: 93)
        var computer = Subject(name: "Computer", score: 97)
        var steve: Student = Student(name: "Steve", id: 2011111050)
        steve.setSubjects(subjects: [math, english, computer])

        let cal = CreditCalculation()
        var avgSteve = cal.studentScoreAvg(student: steve)
        print(avgSteve)
    }

}
