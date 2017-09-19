//
//  ViewController.swift
//  appleMachine
//
//  Created by Kimkeeyun on 16/09/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//  Apple Point mall 만들기

import UIKit



class ViewController: UIViewController {

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
    @IBAction func chargePoints(btnCharge: UIButton) {
        chargeValue += Int(btnCharge.tag)
        displayLabel.text = String(chargeValue) + "원"
        displayLabel.tag = chargeValue
    }
    
    
    enum Product {
        case iphoneX, Airpod, Watch3, WatchBand
        init?(type: String) {
            switch type {
            case "iphoneX":
                self = .iphoneX
            case "Airpod":
                self = .Airpod
            case "Watch3":
                self = .Watch3
            case "WatchBand":
                self = .WatchBand
            default:
                return nil
            }
        }
    }
    
    
    // 물건 구매 버튼(btnBuy) : UIButton
    @IBAction func buyItem(btnBuy: UIButton) {
        if chargeValue >= Int(btnBuy.tag) {
            let product : Product = Product(type: btnBuy.currentTitle!)!
            switch product {
            case .iphoneX:
                notification.text = "iphoneX 구매가 완료되었습니다!"
            case .Airpod:
                notification.text = "Airpod 구매가 완료되었습니다!"
            case .Watch3:
                notification.text = "Watch3 구매가 완료되었습니다!"
            case .WatchBand:
                notification.text = "Watch Band 구매가 완료되었습니다!"
            }
            chargeValue -= btnBuy.tag
            displayLabel.text = String(chargeValue) + "원"
        }else {
            notification.text = "잔액 부족😂 포인트를 충전해주세요!"
        }
    }
}

