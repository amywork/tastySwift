//
//  ViewController.swift
//  appleMachine
//
//  Created by Kimkeeyun on 16/09/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//  Apple Point mall 만들기

import UIKit

class ViewController: UIViewController {
    
    // viewDidLoad시 초기화
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0원"
        notification.text = nil
    }
 
    // 잔액을 보여주는 UILable
    @IBOutlet weak var displayLabel: UILabel!
    

    // 구매 성공 또는 실패를 나타내는 노티피케이션 UILabel
    @IBOutlet var notification: UILabel!
    
    // 충전 또는 구매에 의해 변하는 잔액 변수
    var chargeValue: Int = 0
    
    // 금액 충전 버튼(btnCharge) : UIbutton
    // 3종류: 10만원, 30만원, 50만원 *Int 태그 사용
    // 기능: btnCharge 클릭 시 chargeValue에 금액 추가, displayLabel 값 변경
    @IBAction func chargePoints(btnCharge: UIButton) {
        chargeValue += Int(btnCharge.tag)
        displayLabel.text = String(chargeValue) + "원"
        displayLabel.tag = chargeValue
    }
    
    // 물건 구매 버튼(btnBuy) : UIButton
    // 4가지 종류: 5만원, 10만원, 20만원, 30만원 *Int 태그 사용
    // 01. 잔액 >= 물건 금액 -> 구매 완료 노티피케이션, 잔액 -= 물건금액
    // 02. 잔액 < 물건 금액 -> 구매 실패, 잔액 충전 노티피케이션
    @IBAction func buyItem(btnBuy: UIButton) {
        if chargeValue >= Int(btnBuy.tag) {
            notification.text = "구매가 성공적으로 완료되었습니다!"
            chargeValue -= btnBuy.tag
            displayLabel.text = String(chargeValue) + "원"
        }else {
            notification.text = "잔액 부족😂 포인트를 충전해주세요!"
        }
    }
}

