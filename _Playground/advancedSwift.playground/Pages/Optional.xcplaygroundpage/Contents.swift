//: [Previous](@previous)

import Foundation

let optionalValue: Int? = 5

if let value = optionalValue {
    print("\(value)")
}


func aFunction(optionalValue: Int?) {
    guard let value = optionalValue else {
        print("nil")
        return
    }
    print("\(value)")
}

aFunction(optionalValue: 4)

let wrappedValue = optionalValue ?? 0

optionalValue!

//: [Next](@next)
