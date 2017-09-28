////
////  ViewController.swift
////  0928_UIScrollTable
////
////  Created by 김기윤 on 28/09/2017.
////  Copyright © 2017 younari. All rights reserved.
////
//
//import UIKit
//class suvViewController: UIViewController {
//    
//    var scrollView: UIScrollView!
//    
//    override func viewDidLoad() {
//        // viewDidLoad => 메모리에 view가 로드되는 시점
//        super.viewDidLoad()
//        let rectStyle = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200)
//        scrollView = UIScrollView(frame: rectStyle)
//        scrollView.contentSize = CGSize(width: 1000, height: scrollView.frame.size.height)
//        scrollView.bounces = false // defalut : true
//        scrollView.isPagingEnabled = false // default : false, page = scrollView size
//        view.addSubview(scrollView)
//        
//        for n in 0..<10 {
//            let row = CGFloat(n/10)
//            let column = CGFloat(n%10)
//            let subView: UIView = UIView(frame:  CGRect(x: column*100, y: row*100, width: 100, height: 100))
//            subView.backgroundColor = UIColor(red: column*25/255.0, green: column*0/255.0, blue: row*10/255.0, alpha: 1)
//            scrollView.addSubview(subView)
//        }
//    }
//    
//    // viewDidAppear 이후에 setContentOffset 애니메이션 추가
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        scrollView.setContentOffset(CGPoint(x: 200, y: 0), animated: true)
//        // Offset: 콘텐츠뷰와 스크롤뷰의 교차 좌표, 얼마나 더 가서 시작할 것인지 결정
//    }
//    
//}
//
//
//
//
