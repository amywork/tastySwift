////
////  CompareClass.swift
////  0920_BaseballGame
////
////  Created by 김기윤 on 21/09/2017.
////  Copyright © 2017 younari. All rights reserved.
////  기본 기능 구현 (2017.09.20)
////  1차 Brain : View에서 Model 분리 (2017.09.21)
////  2차 Brain : Enum, Observer 등 활용 (2017.09.21)

import Foundation
class GameBrain {

    private enum AllCase {
        case allStrike
        case ballAndStrike(strike: Int, ball: Int)
        case out
        func printString() -> String {
            switch self {
            case .out:
                return "3 Out 💩"
            case .ballAndStrike(strike: let s, ball: let b):
                return "\(s) Strike, \(b) Ball"
            case .allStrike:
                return "정답입니다👌🏻👏🏻♥️"
            }
        }
    }
    
    func compareCheck(arr1: [Int], arr2: [Int], inputStr: String) -> (SL: String, HL: String) {
        var strike: Int = 0
        var ball: Int = 0
        var checkCase: AllCase
        var historyStr: String?
        var displayStr: String = "" {
            didSet {
                historyStr = inputStr + " 👉🏻 " + displayStr + "\n"
            }
        }
        
        for i in 0..<arr1.count {
            if arr1[i] == arr2[i] {
                strike += 1
            }else if arr2.contains(arr1[i]) {
                ball += 1
            }
        }
        
        if strike + ball == 0 { checkCase = .out }
        else if strike == 3 { checkCase = .allStrike
        }else {
            checkCase = .ballAndStrike(strike: strike, ball: ball)
        }

        switch checkCase {
        case .allStrike:
            displayStr = AllCase.allStrike.printString()
        case .ballAndStrike(strike: let S, ball: let B):
            displayStr = AllCase.ballAndStrike(strike: S, ball: B).printString()
        case .out:
            displayStr = AllCase.out.printString()
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
