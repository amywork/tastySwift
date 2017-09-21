////
////  CompareClass.swift
////  0920_BaseballGame
////
////  Created by 김기윤 on 21/09/2017.
////  Copyright © 2017 younari. All rights reserved.


import Foundation
class GameBrain {

    // 두개의 배열을 받아서, strike / ball을 체크해서 tuple로 넘겨준다.
    func compareCheck(arr1: [Int], arr2: [Int]) -> (s: Int,b: Int) {
        
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
 
    
    
    // 3자릿수의 랜덤수 생성 함수
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
