import Foundation
import UIKit

/*Indirect: Enum으로 tree 만들기*/
indirect enum BinaryTree {
    case leaf
    case node(left: BinaryTree, right: BinaryTree, data: Int)
}

extension BinaryTree {
    func hasData(_ data: Int) -> Bool {
        switch self {
        case .leaf:
            return false
        case let .node(left,right,nodeData) where data == nodeData:
            return true
        case let .node(left,right,nodeData) where data < nodeData:
            return left.hasData(data)
        case let .node(left,right,nodeData) where data > nodeData:
            return right.hasData(data)
        default:
            return false
            //        case let .node(left, right, nodeData):
            //            if data == nodeData {
            //                return true
            //            }else if  {
            //                return left.hasData(data)
            //            }else {
            //                return right.hasData(data)
        }
    }
}

/*Generic*/
indirect enum GenericBinaryTree<T: Comparable & Equatable> {
    case leaf
    case node(left: GenericBinaryTree<T>, right: GenericBinaryTree<T>, data: T)
}

