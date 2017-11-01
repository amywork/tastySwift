//
//  ViewController.swift
//  1101_HighSwift
//
//  Created by 김기윤 on 01/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Function is a sub programming.
    // Reactive X : Observer pattern + Closure + functional
    // Closures can capture and store references to any constants and variables from the context in which they are defined. (maybe in heap)
    // 변수 할당 가능, 문법 단축 사용 가능, trailing 가능
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let someArr = ["a","b","c","d","e","f","g","h","i"]
        let names = [1,2,3,4,5,6,7,8,9,10]
        let sorted = names.sorted { $0 > $1 }
        let sorted2 = someArr.sorted { (_ a, _ b) -> Bool in a < b }
        print(sorted)
        print(sorted2)
        
        let incrementByTen = makeIncrementer(forIncrement: 10)()
        print(incrementByTen)
    }
    
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }

}

