//: [Previous](@previous)

import Foundation
let tuple: (Int, Int) = (3, 6)

let (a, b) = tuple

a
b
tuple.0
tuple.1

let namedTuple: (first: Int, second: Int) = (3,6)

namedTuple.first
namedTuple.second


func getBodyInfo(person: [String: Any] ) -> (height: Int, weight: Int, isAlive: Bool) {
    return (170, 70, true)
}

getBodyInfo(person: [:]).isAlive


let manyValues: (Int, Int, Int, Int) = (1,2,3,4)
manyValues.2

//: [Next](@next)
