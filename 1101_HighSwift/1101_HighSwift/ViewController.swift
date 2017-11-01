//
//  ViewController.swift
//  1101_HighSwift
//
//  Created by 김기윤 on 01/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//  UIViewControllers in ContainerView 😎

import UIKit

class ViewController: UIViewController {
    
    // - Function is a sub programming.
    // - Reactive X : Observer pattern + Closure + functional
    // - Closures can capture and store references to any constants and variables from the context in which they are defined. (maybe in heap)
    // - 변수 할당 가능, 문법 단축 사용 가능, trailing 가능
    
    enum subView: Int {
        case left = 0
        case center = 1
        case right = 2
    }
    
    var tabArray = [UIView]()
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    func swipe(index: Int) {
        for view in tabArray {
            view.isHidden = true
        }
        tabArray[index].isHidden = false
    }
    
    @IBAction func toLeft(_ sender: UIButton) {
        swipe(index: subView.left.rawValue)
    }
    
    @IBAction func toCenter(_ sender: UIButton) {
        swipe(index: subView.center.rawValue)
    }
    
    @IBAction func toRight(_ sender: UIButton) {
        swipe(index: subView.right.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabArray.append(leftView)
        tabArray.append(centerView)
        tabArray.append(rightView)
        
        leftView.isHidden = true
        centerView.isHidden = true
        rightView.isHidden = true
        
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
