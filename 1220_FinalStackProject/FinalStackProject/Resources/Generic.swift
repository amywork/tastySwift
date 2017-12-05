//
//  Generic.swift
//  FinalStackProject
//
//  Created by 김기윤 on 25/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

/*일반적인 Stack 구조 만들기*/
struct StackInt {
    
    private var stackTemp: [Int] = []
    
    mutating func push(_ data: Int) {
        stackTemp.append(data)
    }
    
    mutating func pop() -> Int {
        return stackTemp.removeLast()
    }
    
}

// var stack = Stack<Int>()
// stack.pop()
struct Queue<T> {
    
    private var queArr:[T] = []
    
    mutating func enqueue(_ data: T) {
        queArr.append(data)
    }
    
    mutating func dequeue() {
        queArr.removeFirst()
    }
    
}
