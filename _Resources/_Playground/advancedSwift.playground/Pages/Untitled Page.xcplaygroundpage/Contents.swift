//: Playground - noun: a place where people can play

import UIKit

let constantInt:Int = 3
var variableInt:Int = 3

variableInt = 4
//constantInt = 5

//static var staticVariable: Int = 4


struct someStruct {
    static var constant: Int = 3
}

someStruct.constant


var computedVariable: Int {
    return constantInt * 4
}

computedVariable

var computedGetSet: Int {
    get {
        return constantInt * 4
    }
    
    set {
        variableInt = newValue * 10
    }
}

computedGetSet = 3
computedGetSet




var optionalInt: Int? = 3
optionalInt = nil
//variableInt = nil

//optionalInt * 4

if let striptedInt = optionalInt {
    striptedInt * 4
}

//guard let striptedInt = optionalInt else { return }

let striptedInt = optionalInt ?? 0

indirect enum BinaryTree<T: Equatable & Comparable> {
    case leaf
    case node(left: BinaryTree<T>, right: BinaryTree<T>, data: T)
}

extension BinaryTree {
    func hasData(_ data: T) -> Bool {
        switch self {
        case .leaf:
            return false
        case let .node(_,_,data_) where data == data_ :
            return true
        case let .node(left,_,data_) where data < data_ :
            return left.hasData(data)
        case let .node(_,right,data_) where data > data_ :
            return right.hasData(data)
        case .node:
            return false
        }
    }
}


func enumerate() {
    enum Language: String {
        case swift = "SWIFT"
        case ruby
        case php
        //        case java
        //        case python
        //        case obejctiveC
        //        case javascript
    }
    
    let myLanguage: Language = .swift
    
    switch myLanguage {
    case .swift:
        print("switch: swift")
    case .ruby:
        print("switch: ruby")
    case .php:
        print("switch: php")
    }
    
    print("value: \(myLanguage.rawValue)")
    
    
    enum Chicken {
        case fried
        case soySourced
        case spiceSourced
        case friedWithoutBone
        case soySourcedWithoutBone
        case spiceSourcedWithoutBone
    }
    
    enum Source {
        case soy
        case spice
    }
    
    enum ChickenShort {
        case fried(bone: Bool)
        case sourced(source: Source, bone: Bool)
    }

    let tree: BinaryTree<Int> = .node(
        left: .node( left:  .node(left: .leaf, right: .leaf, data: 1),
                     right: .node(left: .leaf, right: .leaf, data: 3),
                     data: 2),
        
        right: .node( left: .node(left: .leaf, right: .leaf, data: 5),
                     right: .node(left: .leaf, right: .leaf, data: 7),
                     data: 6),
        data: 4)

    tree.hasData(6)
    tree.hasData(10)
   
}

enumerate()


func structExample() {
    //struct 값. copy됨
    // 상속 불가. protocol 구현가능
    
    struct model {
        var id: Int
        var data: Int
    }
    
}

structExample()



let dict: [String: Any] = [:]
dict["aa"]


extension Int {
    func p() {
        print("\(self)")
    }
    var twoTimes: Int {
        return self * 2
    }
}
3.p()

3.twoTimes.p()

let isMultiplesOfTwo: (Int) -> Bool = { value in
    return value % 2 == 0
}

