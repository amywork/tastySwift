//: [Previous](@previous)

import Foundation

protocol BinaryTreeProtocol {
    associatedtype T: Equatable, Comparable
    func hasData(_ data: T) -> Bool
}


class BinaryTree: BinaryTreeProtocol {
    typealias T = Int
    static let leaf: BinaryTree = BinaryTree(left: nil, right: nil, data: nil)
    var left: BinaryTree?
    var right: BinaryTree?
    var data: T?

    init(left: BinaryTree? = BinaryTree.leaf, right:BinaryTree? = BinaryTree.leaf, data: T?) {
        self.left = left
        self.right = right
        self.data = data
    }

    func hasData(_ data: T) -> Bool {
        return true
    }
}


//class BinaryTree: BinaryTreeProtocol {
//    static let leaf: BinaryTree = BinaryTree(left: nil, right: nil, data: nil)
//    var left: BinaryTree?
//    var right: BinaryTree?
//    var data: Int?
//
//    init(left: BinaryTree? = BinaryTree.leaf, right:BinaryTree? = BinaryTree.leaf, data: Int?) {
//        self.left = left
//        self.right = right
//        self.data = data
//    }
//
//    func hasData(_ data: Int) -> Bool {
//        return true
//    }
//}


//class BinaryTree: BinaryTreeProtocol {
//    struct T: Equatable, Comparable {
//        var data: Int
//        static func ==(lhs: T, rhs: T) -> Bool {
//            return lhs.data == rhs.data
//        }
//        static func <(lhs: T, rhs: T) -> Bool {
//            return lhs.data < rhs.data
//        }
//        static func <=(lhs: T, rhs: T) -> Bool {
//            return lhs.data <= rhs.data
//        }
//        static func >=(lhs: T, rhs: T) -> Bool {
//            return lhs.data >= rhs.data
//        }
//        static func >(lhs: T, rhs: T) -> Bool {
//            return lhs.data > rhs.data
//        }
//    }
//
//
//    static let leaf: BinaryTree = BinaryTree(left: nil, right: nil, data: nil)
//    var left: BinaryTree?
//    var right: BinaryTree?
//    var data: T?
//
//    init(left: BinaryTree? = BinaryTree.leaf, right:BinaryTree? = BinaryTree.leaf, data: T?) {
//        self.left = left
//        self.right = right
//        self.data = data
//    }
//
//    func hasData(_ data: T) -> Bool {
//        return true
//    }
//}


//: [Next](@next)
