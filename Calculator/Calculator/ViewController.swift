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
        
        let cal = CreditCalculation()
        
        // 과목마다 Score를 지정하면, 학생별로 과목 인스턴스를 계속 생성해야 되나요?
        let math = Subject(name: "Math")
        math.setScore(score: 95)
        
        let english = Subject(name: "English")
        english.setScore(score: 92)
        
        let computer = Subject(name: "Computer")
        computer.setScore(score: 93)
        
        let s1 = Student(name: "Younari", id: 2011111050)
        s1.setSubjects(subjects: [math, english, computer])
        
        var test = cal.scoreAvgCal(student: s1)
        print(test)
    }
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
        super.didReceiveMemoryWarning()
        
    }
}

