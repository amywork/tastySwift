//
//  ErrorClass.swift
//  FinalStackProject
//
//  Created by 김기윤 on 23/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import UIKit

enum NumberCheckType: Error {
    case negativeNum
    case biggerNum
    case noData
}

class HandlingErrorVC: UIViewController {

    func isSmallNum(baseNum: Int, targetNum: Int?) throws -> Int {
        guard let compareNum = targetNum else {
            throw NumberCheckType.noData
        }
        
        if baseNum < 0 || compareNum < 0 {
            throw NumberCheckType.negativeNum
        }
        
        if compareNum > baseNum {
            throw NumberCheckType.biggerNum
        }
        
        return compareNum
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let num = try isSmallNum(baseNum: 10, targetNum: -1)
            print(num)
        }catch NumberCheckType.biggerNum {
            print("error.biggerNum, 더 작은 숫자를 입력해주세요")
        }catch NumberCheckType.noData {
            print("noData, 값을 입력해주세요")
        }catch NumberCheckType.negativeNum {
            print("negativeNum, 양수를 입력해주세요")
        }catch {
          print("설마 다른 에러가 있을까요?")
        }
    }

}
