////
////  CompareClass.swift
////  0920_BaseballGame
////
////  Created by 김기윤 on 21/09/2017.
////  Copyright © 2017 younari. All rights reserved.
////  기본 기능 구현 (2017.09.20)
////  1차 Brain : View에서 Model 분리 (2017.09.21)

import Foundation
class GameBrain {

    // A. 두개의 비교 대상 배열을 받아서, (strike, ball) tuple로 리턴.
    private func compareCheck(arr1: [Int], arr2: [Int]) -> (s: Int,b: Int) {
        var strike: Int = 0
        var ball: Int = 0
        for i in 0..<arr1.count {
            if arr1[i] == arr2[i] {
                strike += 1
            }else if arr2.contains(arr1[i]) {
                ball += 1
            }
        }
        return (s: strike,b: ball)
    }
    
    // B. (Strike,Ball) 튜플을 받아서 전시할 문자 (스코어라벨,히스토리라벨) 튜플로 바꿔주는 함수
    private func tupleToString(tuple: (s: Int,b: Int), myStr: String) -> (SL: String, HL: String) {
        var displayStr: String = ""
        var historyStr: String = ""
        
        let result = tuple
        if result.s + result.b == 0 {
            displayStr = "3 Out 💩"
        }else if result.s == 3 {
            displayStr = "YES👌🏻👏🏻♥️"
        }else {
            displayStr = "S: \(result.s), B:  \(result.b)"
        }
    
        historyStr = myStr + " ➜ " + displayStr + "\n"
        return (SL: displayStr,HL: historyStr)
    }
    
    // A + B  =  위에 두개 함수를 하나로 합쳐보긔. 요것만 갖다쓰게끔
    func finalSetting(arr1: [Int], arr2: [Int], myStr: String) -> (SL: String, HL: String) {
        let compareResult = compareCheck(arr1: arr1, arr2: arr2)
        let returnResult = tupleToString(tuple: compareResult, myStr: myStr)
        return returnResult
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
