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
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var rightView: UIView!
    var tabArray = [UIView]()
    
    enum subView: Int {
        case left = 1
        case center = 2
        case right = 3
    }
    
    func swipe(index: Int) {
        
    }
    
    @IBAction func toLeft(_ sender: UIButton) {
        leftView.isHidden = false
        centerView.isHidden = true
        rightView.isHidden = true
    }
    
    @IBAction func toCenter(_ sender: UIButton) {
        leftView.isHidden = true
        centerView.isHidden = false
        rightView.isHidden = true
    }
    
    @IBAction func toRight(_ sender: UIButton) {
        leftView.isHidden = true
        centerView.isHidden = true
        rightView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftView.isHidden = true
        centerView.isHidden = true
        rightView.isHidden = true
        
        tabArray.append(leftView)
        tabArray.append(centerView)
        tabArray.append(rightView)
        
        let someArr = ["a","b","c","d","e","f","g","h","i"]
        let names = [1,2,3,4,5,6,7,8,9,10]
        let sorted = names.sorted { $0 > $1 }
        let sorted2 = someArr.sorted { (_ a, _ b) -> Bool in a < b }
        let incrementByTen = makeIncrementer(forIncrement: 10)()
        print(incrementByTen)
        print(sorted)
        print(sorted2)
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
