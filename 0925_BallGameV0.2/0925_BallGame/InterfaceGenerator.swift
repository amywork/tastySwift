//
//  Generator.swift
//  0925_BallGame
//
//  Created by 김기윤 on 25/09/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//
import UIKit
import Foundation

class InterfaceGenerator {
    var brain = GameBrain()
    var displayLabelList: Array<UILabel> = []
    var isRunning: Bool = false
    var selectedNumberList: [Int] = []
    var randomNumberList: [Int] = []
    var historyStr: String = ""
    var displayLabelStr: String {
        get {
            var str: String = ""
            for i in 0..<3 { str += "\(selectedNumberList[i])" }
            return str
        }
    }
    
    func play(scoreLB: UILabel, historyLB: UITextView) {
        isRunning = true
        selectedNumberList = []
        historyStr = ""
        randomNumberList = brain.makeRandomList()
        for label in displayLabelList {
            label.text = "-"
        }
        scoreLB.text = "시작해볼까요?👻"
        historyLB.text = ""
    }
    
    func delete() {
        for label in displayLabelList {
            label.text = "-"
        }
        selectedNumberList = []
    }

    func btnClick(_ sender: UIButton, scoreLB: UILabel) {
        if isRunning {
            let selectedNum = sender.tag
            if selectedNumberList.count < displayLabelList.count && !selectedNumberList.contains(selectedNum) {
                selectedNumberList.append(selectedNum)
                let lastIndex = selectedNumberList.count - 1
                let inputLabel = displayLabelList[lastIndex]
                inputLabel.text = "\(selectedNum)"
            }else if selectedNumberList.count >= displayLabelList.count {
                scoreLB.text = "Check 버튼을 눌러주세요!"
            }else if selectedNumberList.contains(selectedNum) {
                scoreLB.text = "숫자 중복은 안돼요 🤡"
            }
        }
    }
    

    func check(scoreLB: UILabel, historyLB: UITextView) {
        if isRunning && selectedNumberList.count == displayLabelList.count {
            let finalStr = brain.compareCheck(arr1: selectedNumberList, arr2: randomNumberList, inputStr: displayLabelStr)
            scoreLB.text = finalStr.SL
            historyStr += finalStr.HL
            historyLB.text = historyStr
            selectedNumberList = []
            for label in displayLabelList {
                label.text = "-"
            }
        }else if isRunning && selectedNumberList.count < displayLabelList.count {
            scoreLB.text = "숫자 3개를 모두 선택해주세요"
        }else if !isRunning {
            scoreLB.text = "play 버튼을 눌러주세요"
        }
    }
    

}

