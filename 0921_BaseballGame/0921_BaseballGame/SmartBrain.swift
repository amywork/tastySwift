////
////  CompareClass.swift
////  0920_BaseballGame
////
////  Created by 김기윤 on 21/09/2017.
////  Copyright © 2017 younari. All rights reserved.
////  기본 기능 구현 (2017.09.20)
////  1차 Brain : View에서 Model 분리 (2017.09.21)
////  2차 Brain : Enum을 활용한 Brain 입니다. (2017.09.21)

import Foundation
class SmartBrain {
    
    private enum PickCase {
        case allStrike
        case ballAndStrike(strike: Int, ball: Int)
        case out
        func printString() -> String { // 라벨 출력 용도의 메소드
            switch self {
            case .out:
                return "3 Out 💩"
            case .ballAndStrike(strike: let s, ball: let b):
                return "\(s) Strike, \(b) Ball"
            case .allStrike:
                return "정답이에요👌🏻👏🏻♥️"
            }
        }
    }
    
    func compareCheck(arr1: [Int], arr2: [Int], inputStr: String) -> (SL: String, HL: String) {
        var strike: Int = 0
        var ball: Int = 0
        var caseCheck: PickCase
        
        for i in 0..<arr1.count {
            if arr1[i] == arr2[i] {
                strike += 1
            }else if arr2.contains(arr1[i]) {
                ball += 1
            }
        }
        
        // Property Observer
        var historyStr: String?
        var displayStr: String = "" {
            didSet {
                historyStr = inputStr + " 👉🏻 " + displayStr + "\n"
            }
        }
        
        if strike + ball == 0 {
            displayStr = PickCase.out.printString()
        }else if strike == 3 {
            displayStr = PickCase.allStrike.printString()
        }else {
            displayStr = PickCase.ballAndStrike(strike: strike, ball: ball).printString()
        }
        
        return (SL: displayStr, HL: historyStr!)
    }
    
    // 랜덤의 3자리 Int 생성 함수
    func makeRandomList() -> [Int] {
        var randomNumberList: [Int] = []
        while randomNumberList.count < 3 {
            let randomNum: Int = Int(arc4random_uniform(10))
            if !randomNumberList.contains(randomNum) {
                randomNumberList.append(randomNum)
            }
        }
        return randomNumberList
    }
    
}
