//
//  ViewController.swift
//  0920_BaseballGame
//
//  Created by 김기윤 on 21/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//  목표: ViewController는 최대한 UI 관련된 일만 하게끔 처리
//  라벨, 버튼 입력 등의 일은 뷰 콘트롤러가 진행

import UIKit

class ViewController: UIViewController {
    
    //Mark - 00. UI 연관 Property
    private var isRunning: Bool = false
    private var displayLabelList: [UILabel]?
    private var selectedNumberList: [Int]?
    private var randomNumberList: [Int]?
    private var historyStr: String?
    private var displayLabelStr: String { // [Int] -> String 변환 후 전시하기 위함, Computed property
        get {
            var str: String = ""
            for i in 0..<3 { str += "\(selectedNumberList![i])" }
            return str
        }
    }
    
    //Mark - 01. UILabel
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var displayLabel01: UILabel!
    @IBOutlet weak var displayLabel02: UILabel!
    @IBOutlet weak var displayLabel03: UILabel!
    @IBOutlet weak var historyLabel: UITextView!
    
    // Mark - 02. ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabelList = [displayLabel01,displayLabel02,displayLabel03] // LB 초기화
    }
    
    //Mark - 03. Start button : 시작
    @IBAction func btnReplay(_ sender: UIButton) {
        isRunning = true
        randomNumberList = brain.makeRandomList()
        scoreLabel.text = "시작해볼까요? 👻"
        resetProperty()
        historyStr = "" // 초기화
        historyLabel.text = ""
    }
    
    //Mark - 04. Clear Button (숫자 지우기)
    @IBAction func btnCancel(_ sender: UIButton) {
        resetProperty()
    }
    
    //Mark - 05. UIButton: btnNum click
    @IBAction func btnNumClick(_ sender: UIButton) {
        if isRunning {
            let selectedNum = sender.tag
            if selectedNumberList!.count < displayLabelList!.count && !selectedNumberList!.contains(selectedNum) {
                selectedNumberList?.append(selectedNum)
                let lastIndex = selectedNumberList!.count - 1
                let inputLabel = displayLabelList![lastIndex]
                inputLabel.text = "\(selectedNum)"
            }else if selectedNumberList!.count >= displayLabelList!.count {
                scoreLabel.text = "확인 버튼을 누르세요👇🏻"
            }else if selectedNumberList!.contains(selectedNum) {
                scoreLabel.text = "숫자 중복은 안돼요 🤡"
            }
        }
    }
    
    //Mark - 06. 연산: btnCheck - UIButton
    //연산 로직을 담고 있는 SmartBrain(모델) 의 instance 생성
    let brain: SmartBrain = SmartBrain()
    
    @IBAction func btnCheck(_ sender: UIButton) {
        if isRunning && selectedNumberList!.count == displayLabelList!.count {
            let finalStr = brain.compareCheck(arr1: selectedNumberList!, arr2: randomNumberList!, inputStr: displayLabelStr)
            scoreLabel.text = finalStr.SL
            historyStr! += finalStr.HL
            historyLabel.text = historyStr
        }
        resetProperty()
    }
    
    //초기화 함수
    func resetProperty() {
        selectedNumberList = []
        for label in displayLabelList! {
            label.text = "-"
        }
    }
    
}
