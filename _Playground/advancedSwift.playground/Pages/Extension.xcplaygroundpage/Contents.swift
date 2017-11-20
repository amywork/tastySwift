//: [Previous](@previous)

import Foundation

extension Int {
    var double: Int {
        return self * 2
    }
    
    func times(_ time: Int) -> Int {
        return self * time
    }
}

3.double
3.times(5)

enum API {
    case getList
    case getDetail
}

extension API {
    var host: String {
        return "https://apiserver.com"
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/list"
        case .getDetail:
            return "/detail"
        }
    }
    
    var url: URL? {
        return URL(string: "\(self.host)\(self.path)")
    }
}

API.getDetail.url

struct Position {
    var x: Float
    var y: Float
}

extension Position {
    func transform(withOther position: Position) -> Position {
        return Position(x: self.x + position.x, y: self.y + position.y)
    }
}

class SomeClass {
    
}

extension SomeClass {
    func someFunction() {
        
    }
}

//class ExtnededClass: SomeClass {
//    override func someFunction() {
//
//    }
//}
//
//ExtnededClass().someFunction()

//: [Next](@next)
