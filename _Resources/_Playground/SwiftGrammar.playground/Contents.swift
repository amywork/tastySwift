import UIKit
import Foundation
import PlaygroundSupport

/*Extension:
 1. Function & Property 확장,
 2. Computed property 확장,
 3. Stored property는 확장 불가*/

/*extension Int*/
extension Int {
    var double: Int {
        return self * 2
    }
    func times(_ time: Int) -> Int {
        return self * time
    }
}

3.double
3.times(100)


/*extension position*/
struct Position {
    var x: Float
    var y: Float
}

extension Position {
    func transfrom(withOther position: Position) -> Position {
        return Position(
            x: self.x + position.x,
            y: self.y + position.y)
    }
}

Position(x: 0.5, y: 7.5).transfrom(
    withOther: Position(x: 1, y: 1))


/*extension API enum*/
enum API {
    case getList
    case getDetail(id: Int)
}

extension API {
    var host: String {
        return "https://apiserver.com"
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/list"
        case .getDetail(let id):
            return "/list/\(id)/detail"
        }
    }
    
    var url:URL? {
        return URL(string: self.host + self.path)
    }
}

API.getDetail(id: 5).url


/*Class : 실습 없음*/
/*Enumeration combined with switch*/
enum Source {
    case soySource
    case spicySource
}

enum ChickenShort {
    case fried(bone: Bool)
    case sourced(source: Source, bone: Bool)
}

// 뼈없는 간장치킨
let choicedChicken = ChickenShort.sourced(source: .soySource, bone: false)

/*Protocol*/
/*Associated Type: Protocol이 사용하는 Generic이다.*/

/*Closure*/
/*circular chain 피하기 위해 weak self 쓰는 연습 하기, @escape*/
let isMultipleOfTwo: (Int) -> Bool = { value in
    return value % 2 == 0
}

/*Closure + Optional*/
var double: ((Int) -> Int)? =  nil
double?(2)


let multiply: (Int,Int) -> Int = { (value1, value2) in
    return value1*value2
}

let addition: (Int, Int) -> Int =  { (value1, value2) in
    return value1+value2
}

multiply(2, 3)
addition(2, 3)


func printResultByMutableOperation(value1: Int, value2: Int, operation:(Int,Int) -> Int) -> Void {
    print("result: \(operation(value1, value2))")
}

printResultByMutableOperation(value1: 1, value2: 3, operation: addition)
printResultByMutableOperation(value1: 9, value2: 8) { $0 * $1 }


/*Closure Curling*/
func add(value: Int) -> (Int) -> Int {
    return { value2 in return value + value2 }
}

let addTwo = add(value: 2)
addTwo(10)
add(value: 10)(2)



/*tuple with named*/
let nameTuple: (first: Int, second: Int) = (3,6)
nameTuple.first
nameTuple.second

/*tuple with switch*/
let tuple: (Int,Int) = (3,5)
switch tuple {
case let (a,_):
    print("a: \(a)")
}


