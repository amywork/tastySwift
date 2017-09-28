//
//  ViewController.swift
//  0928_UIScrollTable
//
//  Created by 김기윤 on 28/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var subView: UIView = UIView()
    var subViewArr: [UIView] = []
    
    override func viewDidLoad() {
        // viewDidLoad => 메모리에 view가 로드되는 시점
        super.viewDidLoad()
        let rectStyle = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        scrollView = UIScrollView(frame: rectStyle)
        scrollView.delegate = self // UIScrollViewDelegate
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width*3, height: scrollView.frame.size.height)
        view.addSubview(scrollView)
        
        for n in 0..<3 {
            subView = UIView()
            subView.tag = n
            subView.frame = CGRect(x: CGFloat(n)*view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            scrollView.addSubview(subView)
            subView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            subViewArr.append(subView)
        }
    
        // UISwitch
        let switcher:UISwitch = UISwitch(frame: CGRect(x: view.frame.size.width/2 - 50, y: view.frame.size.height/2 - 50, width: 50, height: 50))
        switcher.addTarget(self, action: #selector(ViewController.valueChangeSwitcher), for: .valueChanged)
        // switch = > valueChanged
        scrollView.addSubview(switcher)
    }

    @objc func valueChangeSwitcher(_ sender: UISwitch) {
        if sender.isOn {
            subViewArr[0].backgroundColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        }else {
            subViewArr[0].backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX: CGFloat = scrollView.contentOffset.x
         let colorValue: CGFloat = 1 - (offsetX/(scrollView.contentSize.width - scrollView.frame.size.width))
        for i in 0..<3 {
            subViewArr[i].backgroundColor = UIColor(white: colorValue, alpha: 1)
        }
    }
    
    // viewDidAppear 이후에 setContentOffset 애니메이션 추가
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        // Offset: 콘텐츠뷰와 스크롤뷰의 교차 좌표, 얼마나 더 가서 시작할 것인지 결정
    }
}

