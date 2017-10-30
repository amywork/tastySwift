//: [Previous](@previous)

import Foundation

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
        case let .getDetail(id):
            return "/list/\(id)/detail"
        }
    }
    
    var url: URL? {
        return URL(string: "\(self.host)\(self.path)")
    }
}

API.getList.url
API.getDetail(id: 37).url

indirect enum BinaryTree{
    case leaf
    case node(left: BinaryTree, right: BinaryTree, data: Int)
}

let tree: BinaryTree = .node(
    left: .node( left:  .node(left: .leaf, right: .leaf, data: 1),
                 right: .node(left: .leaf, right: .leaf, data: 3),
                 data: 2),
    
    right: .node( left: .node(left: .leaf, right: .leaf, data: 5),
                  right: .node(left: .leaf, right: .leaf, data: 7),
                  data: 6),
    data: 4)


extension BinaryTree {
    func hasData(_ data: Int) -> Bool {
        switch self {
        case .leaf:
            return false
        case let .node(_,_,nodeData) where data == nodeData :
            return true
        case let .node(left,_,nodeData) where data < nodeData :
            return left.hasData(data)
        case let .node(_,right,nodeData) where data > nodeData :
            return right.hasData(data)
        case .node:
            return false
        }
    }
}

tree.hasData(6)
tree.hasData(10)

//: [Next](@next)
