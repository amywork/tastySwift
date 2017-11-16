//: Playground - noun: a place where people can play
import Foundation
import UIKit
/*Optional:crash 0까지 줄이기 -> if let, guard let, ??*/

/*Map, FlatMap, Filter*/
/*
 1. Map: Array의 원소들을 다른 원소들로 바꿔주는 것 Domain(X) -> Codomain(Y)
 2. FlatMap: Array 사이에 nil이 있을 때 nil을 제거하기 위함
 map closure type: (T) -> U
 [T] -> T -> U -> [U]
 flatMap closure type: (T) -> U?
 [T] -> T -> U? -> [U]
 */

let array = [0,10,2,203,43,23,3241,32103,]
array.map { (item: Int) -> String in
    return "\(item+10)"
}

let stringArr = ["good", "https://google.com", "https://agit.io", "some"]
stringArr.flatMap { (string: String) -> String? in
    return URL(string: string)?.host
}


let quizStr = "ab2v9bc13j5jf4jv21"
let ranges = (try? NSRegularExpression(pattern: "[0-9]+").matches(in: quizStr, range: NSRange(quizStr.startIndex...,in: quizStr))) ?? []

let numberStrings = ranges.flatMap { Range($0.range, in: quizStr) }.map { String(quizStr[$0]) }
print(numberStrings)

let squares = numberStrings.flatMap { Int($0) }.filter { $0 % 2 != 0 }.map { $0 * $0 }
print(squares)

let result = squares.reduce(0, +)
print(result)


