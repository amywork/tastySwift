//
//  BlockScrollViewController.swift
//  0928_UIScrollTable
//
//  Created by Kimkeeyun on 03/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class BlockScrollViewController: UIViewController {

    var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let rectStyle = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 500)
        scrollView = UIScrollView(frame: rectStyle)
        scrollView.contentSize = CGSize(width: 1000, height: scrollView.frame.size.height)
        scrollView.bounces = true // defalut : true
        scrollView.isPagingEnabled = false // default : false, page = scrollView size
        view.addSubview(scrollView)
        
        for n in 0..<50 {
            let row = CGFloat(n/10)
            let column = CGFloat(n%10)
            let subView: UIView = UIView(frame: CGRect(x: column*100, y: row*100, width: 100, height: 100))
            subView.backgroundColor = UIColor(red: column*13/255.0, green: row*25/255.0, blue: 1.0, alpha: 1)
            scrollView.addSubview(subView)
        }
        
        // UISwitch
        let colorSwitcher: UISwitch = UISwitch(frame: CGRect(x: 10, y: view.frame.size.height-36, width: 20, height: 20))
        colorSwitcher.addTarget(self, action: #selector(BlockScrollViewController.colorChange), for: .valueChanged)
        self.view.addSubview(colorSwitcher)
    }
    
    @objc func colorChange(_ sender: UISwitch) {
        if sender.isOn {
            view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.331463933, blue: 0.3345415592, alpha: 1)
        }
    }
    
    // viewDidAppear 이후에 setContentOffset 애니메이션 추가
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.setContentOffset(CGPoint(x: 200, y: 0), animated: true)
        // Offset: 콘텐츠뷰와 스크롤뷰의 교차 좌표, 얼마나 더 가서 시작할 것인지 결정
    }
    
}
