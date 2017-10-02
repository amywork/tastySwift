//
//  ViewController.swift
//  0928_UIScrollTable
//
//  Created by 김기윤 on 28/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class GradationViewController: UIViewController, UIScrollViewDelegate {
    
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
            subView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            subViewArr.append(subView)
        }
        

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX: CGFloat = scrollView.contentOffset.x
        let colorValue: CGFloat = 1 - (offsetX/scrollView.contentSize.width)
        for i in 0..<3 {
            subViewArr[i].backgroundColor = UIColor(red: 1, green: colorValue, blue: colorValue, alpha: 1)
        }
    }
    
    // viewDidAppear 이후에 setContentOffset 애니메이션 추가
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        // Offset: 콘텐츠뷰와 스크롤뷰의 교차 좌표, 얼마나 더 가서 시작할 것인지 결정
    }
}






