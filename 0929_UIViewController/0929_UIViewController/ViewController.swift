//
//  ViewController.swift
//  0929_UIViewController
//
//  Created by 김기윤 on 29/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UIScrollViewDelegate {

    var list:[Int]!
    //viewDidLoad는 거의 1번만 불리나, 메모리워닝 나면 또불림
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewDidLoad가 또불리는 경우를 생각해서 예외처리
        if list == nil
        {
            list = []
        }
        createView()
        updateLayout()
    }

    //Reference Counting 에 대한 내용은 추후 진행
    //weak var : 변수의 소유자를 1명에게 몰아주기 위함, 세입자
    weak var gateView:UIView!
    weak var mainTitle:UILabel!
    weak var scrollArea:UIScrollView!
    weak var btn:UIButton!
    
    //클로저로서 한 번만 실행하고 그 값을 gateView2변수가 갖고있는 형태
    let gateView2: UIView = {
        let gateView: UIView = UIView()
        gateView.backgroundColor = UIColor(red: 122/255, green: 0.5, blue: 0.5, alpha: 1)
        gateView.alpha = 0.5 // 이렇게 alpha값을 직접 주면 얘의 서브뷰도 다 영향을 받음
        gateView.tag = 2 // 뷰의 구분을 위해 쓰는 아이
        return gateView
    }()
    
    
    let closure = { (input: Int) -> Int in return input + 1 }
    
    func createView() {
        //gateView
        view.addSubview(gateView2)
        self.gateView = gateView2
        
        //mainTitle Label
        let mainTitle: UILabel = UILabel()
        self.view.addSubview(mainTitle)
        mainTitle.text = "Flat White"
        //Label의 attributedText 값을 지정하기 -> google
        //text와 attributedText를 두번 지정할 필요는 없다.
//        let attributedString = NSMutableAttributedString(string: "Flat White")
//        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: 0)
//        mainTitle.text = attributedString
        mainTitle.font = UIFont.boldSystemFont(ofSize: 17)
        mainTitle.tag = 17
        self.mainTitle = mainTitle
        
        
        //UIButton, type은 init 할 때만 지정할 수 있음! // type default는 커스텀
        //buttonType은 get만 있는 read Only 읽기 전용이다.
        //UIControl은 상태(normal, selected)가 존재하기 때문에, 타이틀을 입력할 때 상태도 함께 입력해야 한다.
        //Type, setTitle에서 ControlState (normal, highlighted..), addTarget
        //target = self: selector에 들어가는 메소드가 실행이 될 인스턴스 = 자기자신, viewController
        let btn:UIButton = UIButton(type: .custom)
        btn.setTitle("구매하기", for: .normal)
        btn.setTitle("구매하러 가시겠습니까?", for: .highlighted)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        btn.addTarget(self, action: #selector(self.btnAction(_sender:)), for: .touchUpInside)
        view.addSubview(btn)
        self.btn = btn
        
        let scrollArea: UIScrollView = UIScrollView()
        view.addSubview(scrollArea)
        scrollArea.delegate = self
        self.scrollArea = scrollArea
        scrollArea.bounces = false
        // scrollArea.contentOffset
        // scrollArea.isDecelerating (감속)

    }
    
    func updateLayout() {
        let screenWidthModule: CGFloat = view.frame.size.width-32
        let viewHeight: CGFloat = 260
        gateView.frame = CGRect(x: 16, y: 0, width: screenWidthModule, height: viewHeight)
        btn.frame = CGRect(x: 100, y: 100, width: 160, height: 50)
        mainTitle.frame = CGRect(x: 100, y: 300, width: screenWidthModule, height: 160)
        scrollArea.frame = CGRect(x: 16, y: gateView.frame.size.height + 16, width: screenWidthModule, height: viewHeight)
        scrollArea.contentSize = CGSize(width: scrollArea.frame.width*10, height: scrollArea.frame.size.height)
    }
    
    @objc func btnAction(_sender: UIButton) {
        
    }
}

