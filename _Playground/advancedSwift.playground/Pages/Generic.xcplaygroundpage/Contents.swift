//: [Previous](@previous)

import Foundation

indirect enum BinaryTree<T: Comparable & Equatable>{
    case leaf
    case node(left: BinaryTree<T>, right: BinaryTree<T>, data: T)
}

let tree: BinaryTree<Int> = .node(
    left: .node( left:  .node(left: .leaf, right: .leaf, data: 1),
                 right: .node(left: .leaf, right: .leaf, data: 3),
                 data: 2),
    
    right: .node( left: .node(left: .leaf, right: .leaf, data: 5),
                  right: .node(left: .leaf, right: .leaf, data: 7),
                  data: 6),
    data: 4)

let stringTree: BinaryTree<String> = .node(left: .leaf, right: .leaf, data: "1")

extension BinaryTree {
    func hasData(_ data: T) -> Bool {
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

stringTree.hasData("1")
stringTree.hasData("2")

//: [Next](@next)
