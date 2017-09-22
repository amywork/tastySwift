////
////  CompareClass.swift
////  0920_BaseballGame
////
////  Created by 김기윤 on 21/09/2017.
////  Copyright © 2017 younari. All rights reserved.
////  기본 기능 구현 (2017.09.20)
////  View에서 Model 분리 (2017.09.21)
////  Enum을 활용한 Brain 입니다.

import Foundation
class SmartBrain {
    
    // Strike 및 Ball의 케이스를 담고있는 Enum
    private enum PickCase {
        case allStrike //"YES👌🏻👏🏻♥️"
        case ballAndStrike(strike: Int, ball: Int) //"S: \(strike), B:  \(ball)"
        case out //"3 Out 💩"
    }

    func compareCheck(arr1: [Int], arr2: [Int], myStr: String) -> (SL: String, HL: String) {
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
        
        if strike + ball == 0 {
            caseCheck = PickCase.out
        }else if strike == 3 {
            caseCheck = PickCase.allStrike
        }else {
            caseCheck = PickCase.ballAndStrike(strike: strike, ball: ball)
        }
        
        var displayStr: String = ""
        var historyStr: String = ""
        
        switch caseCheck {
        case .out:
            displayStr = "3 Out 💩"
        case .ballAndStrike:
            displayStr = "S: \(strike), B:  \(ball)"
        case .allStrike:
            displayStr = "YES👌🏻👏🏻♥️"
        }
        
        historyStr = myStr + " ➜ " + displayStr + "\n"
        return (SL: displayStr, HL: historyStr)
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
