//
//  ViewController.swift
//  0920_BaseballGame
//
//  Created by 김기윤 on 21/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    //Mark - 00. Property 목록
    private var isRunning: Bool = false
    private var displayLabelList: [UILabel]?
    private var selectedNumberList: [Int]?
    var numStrike: Int = 0
    var numBall: Int = 0
    var randomNumberList: [Int]?
    var historyStr: String = ""

    //Mark - 01. UILabel 정의
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var displayLabel01: UILabel!
    @IBOutlet weak var displayLabel02: UILabel!
    @IBOutlet weak var displayLabel03: UILabel!
    @IBOutlet weak var historyLabel: UITextView!
    
  
    // Mark - 02. ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabelList = [displayLabel01,displayLabel02,displayLabel03]
    }
    
    //Mark - 03. Start button Click : 시작
    // Running, 랜덤 넘버 만들어주기, 숫자 및 라벨 초기화
    @IBAction func btnReplay(_ sender: UIButton) {
        isRunning = true
        randomNumberList = makeRandomList()
        selectedNumberList = []
        historyStr = ""
        historyLabel.text = ""
        scoreLabel.text = ""
        for label in displayLabelList! {
            label.text = "-"
        }
    }

    //Mark - 04. UIButton: btnNumber click
    //유저가 버튼을 누르기 시작합니다.
    @IBAction func btnNumClick(_ sender: UIButton) {
        if isRunning {
            let selectedNum = sender.tag
            if selectedNumberList!.count < displayLabelList!.count && !selectedNumberList!.contains(selectedNum) {
                selectedNumberList?.append(selectedNum)
                let lastIndex = selectedNumberList!.count - 1
                let inputLabel = displayLabelList![lastIndex]
                inputLabel.text = "\(selectedNum)"
            }
        }
    }
    
    
    //연산 Brain 의 instance 생성
    var brain: gameBrain = gameBrain()
    
    //Mark - 05. UIButton: btnCheck, btnCancel, btnReplay
    @IBAction func btnCheck(_ sender: UIButton) {
        if isRunning && selectedNumberList!.count == displayLabelList!.count {
            
            
            // Brain에게 계산을 부탁함
            let result = brain.compareCheck(arr1: selectedNumberList!, arr2: randomNumberList!)

            
            //scoreLabel, history에 전시
            var displayLabelStr: String = ""
            for i in 0..<3 {
                displayLabelStr += "\(selectedNumberList![i])"
            }
            
            if result.s + result.b == 0 {
                scoreLabel.text = "3 Out!"
                historyStr += displayLabelStr + " : 3 Out! \n"
            }else if result.s == 3 {
                scoreLabel.text = "Right👌🏻👏🏻♥️"
                historyStr += displayLabelStr + " Right👌🏻👏🏻♥️"
            }else {
                scoreLabel.text = "S: \(result.s), B:  \(result.b)"
                historyStr += displayLabelStr + " S: \(result.s), B:  \(result.b) \n"
            }
            
            
            
//이전 코드
//            for i in 0..<3 {
//                if selectedNumberList?[i] == randomNumberList?[i] {
//                    numStrike += 1
//                }else if randomNumberList!.contains(selectedNumberList![i]) {
//                    numBall += 1
//                }
//            }
//
//            if numStrike + numBall == 0 {
//                scoreLabel.text = "3 Out!"
//                historyStr += displayLabelStr + " 3 Out! \n"
//            }else if numStrike == 3 {
//                scoreLabel.text = "Right👌🏻👏🏻♥️"
//                historyStr += displayLabelStr + " Right👌🏻👏🏻♥️"
//            }else {
//                scoreLabel.text = "S: \(numStrike), B:  \(numBall)"
//                historyStr += displayLabelStr + " S: \(numStrike), B:  \(numBall) \n"
//            }
        }
        
        selectedNumberList = []
        historyLabel.text = historyStr
        numStrike = 0
        numBall = 0
        for label in displayLabelList! {
            label.text = "-"
        }
    }
    
    //Mark - 06. UIButton: Clear (숫자 지우기)
    @IBAction func btnCancel(_ sender: UIButton) {
        selectedNumberList = []
        for label in displayLabelList! {
            label.text = "-"
        }
    }

    //Random Method
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

