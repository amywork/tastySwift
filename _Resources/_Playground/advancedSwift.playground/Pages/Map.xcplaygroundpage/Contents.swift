//: [Previous](@previous)

import Foundation

let array = [0, 1,2,3,4,5,6,7]

array.map { (item: Int) -> String in
    "\(item*10)"
}

array.map { (item: Int) -> Bool in
    item % 2 == 0
}

array.filter { (item: Int) -> Bool in
    item % 2 == 0
}

let stringArray = ["good", "http://google.com" , "http://agit.io" , "some words"]

let hosts = stringArray.flatMap { (string: String) -> String? in
    return URL(string: string)?.host
}

hosts.forEach { (host) in
    print(host)
}

//: [Next](@next)

// 맵이 없던 시절엔

let oldArray = [1,2,3,4,5,6,7,8]
var newArray: [String] = []

for item in oldArray {
    newArray.append(String(item))
}
newArray

var filteredArray: [Int] = []
for item in oldArray {
    if item % 2 == 0 {
        filteredArray.append(item)
    }
}
filteredArray


//https://www.wanted.co.kr/wd/5680?industry_id=489

let string = "ab2v9bc13j5jf4jv21"
let numberArray = (try? NSRegularExpression(pattern: "[0-9]+").matches(in: string, range: NSRange(string.startIndex..., in: string)).flatMap { Range($0.range, in: string) }.map { String(string[$0]) }) ?? []

let r = numberArray.flatMap{ (number: String) -> Int? in
    return Int(number)
    }.filter { (value: Int) -> Bool in
        return value % 2 != 0
    }.map { $0 * $0 }.reduce(0, +)
print(r)

