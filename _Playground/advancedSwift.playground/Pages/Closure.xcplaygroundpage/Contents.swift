//: [Previous](@previous)

import Foundation

let double: (Int) -> Int = { value in
    return value * 2
}

double(3)

let multiply: (Int, Int) -> Int = { value1, value2 in
    return value1 * value2
}

multiply(2, 3)

let addition: (Int, Int) -> Int = { value1, value2 in
    return value1 + value2
}

func printResultByMutableOperator(value1: Int, value2: Int, operator mutableOperator: (Int, Int) -> Int) {
    print("result: \(mutableOperator(value1, value2))")
}

printResultByMutableOperator(value1: 3, value2: 5, operator: addition)
printResultByMutableOperator(value1: 3, value2: 5, operator: multiply)

printResultByMutableOperator(value1: 3, value2: 5) { (value1, value2) -> Int in
    return (value1 + value2) * value2 / value1
}


func add(value: Int) -> (Int) -> Int {
    return { value2 in
        return value + value2
    }
}

let addTwo = add(value: 2)
addTwo(10)

//: [Next](@next)
