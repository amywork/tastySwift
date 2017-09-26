//
//  ViewController.swift
//  0925_UIViewPractice
//
//  Created by 김기윤 on 25/09/2017.
//  Copyright © 2017 younari. All rights reserved.

import UIKit

class ViewController: UIViewController {

    var logoLabel: UILabel = UILabel()
    var contentTitleLabel: UILabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gnbView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 58))
        self.view.addSubview(gnbView)
        
        let magazineFooterView: UIView = UIView()
        self.view.addSubview(magazineFooterView)
        magazineFooterView.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.9)
        magazineFooterView.frame = CGRect(x: 0, y:view.frame.size.height-100, width: view.frame.size.width, height: 100)
        
        
        // MARK -- Generate Kinfolk Logo
        logoLabel = UILabel(frame: CGRect(x: 16, y: 36, width: self.view.frame.width-32, height: 20))
        // MARK -- addSubview의 위치는 상관 없으나, 그래도 변수 선언하고 바로 추가하기
        gnbView.addSubview(logoLabel)
        
        logoLabel.text = "Kinfolk"
        logoLabel.textAlignment = .left
        logoLabel.font = UIFont.systemFont(ofSize: 16) // UIFont.font는 Instance
        logoLabel.textColor = UIColor.darkGray // logoLabel.shadowColor = UIColor.darkGray
        
		// Q.MARK -- font Weight
        //UIFont.Weight : ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
        logoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        logoLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy)
	    // Q.MARK -- Custom Font type은 어떻게 설정하나요?, 예를 들어 구글 폰트 임베드 하고 싶을 때?
		// logoLabel.font = UIFont(name: "Font Name", size: 16)
        
   
        // MARK -- Generate Magazine Contents Module
        let contentModuleView: UIView = UIView()
        self.view.addSubview(contentModuleView)
        contentModuleView.frame = CGRect(x: 0, y: 58, width: self.view.frame.width, height: 534)
        contentModuleView.backgroundColor = UIColor.lightGray
        contentModuleView.alpha = 1
        
        // MARK -- subview clipping?
        contentModuleView.clipsToBounds = false
        contentModuleView.autoresizesSubviews = true
        
        
        // MARK -- Generate Magazine Contents Top & Bottom Background Module View
        let contentModuleHalfTopView: UIView = UIView()
        contentModuleView.addSubview(contentModuleHalfTopView)
        contentModuleHalfTopView.backgroundColor = UIColor.white
        contentModuleHalfTopView.frame = CGRect(x: 0, y: 0, width: contentModuleView.frame.width, height: contentModuleView.frame.height/2)
    
        let contentModuleHalfBottomView: UIView = UIView()
        contentModuleView.addSubview(contentModuleHalfBottomView)
        contentModuleHalfBottomView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentModuleHalfBottomView.frame = CGRect(x: 0, y: contentModuleView.frame.height/2, width: contentModuleView.frame.width, height: contentModuleView.frame.height/2)
        
        // MARK -- Generate Magazine Contents Module -- ImageView
        let contentImageView: UIImageView = UIImageView()
        contentModuleView.addSubview(contentImageView)
        
        // MARK -- 상위뷰 표현 어떻게? -- 상위뷰의 이름을 쓰기
	    contentImageView.frame = CGRect(x: 8, y: 8, width: 359, height: 359)
        contentImageView.image = UIImage(named: "fritzHansen_04.jpg")  // UIImageView.image (image는 instance)
        contentImageView.contentMode = UIViewContentMode.scaleAspectFill // contentMode (UIView의 속성)
        
        //Q.MARK -- image가 isHighlighted (눌렀을 때)
        contentImageView.isHighlighted = true
        contentImageView.highlightedImage = UIImage(named: "fritzHansen_02.jpg")
        contentImageView.isUserInteractionEnabled = true
        
        // MARK -- Generate Magazine Contents Module > ImageView > contentTitleLabel
        contentModuleView.addSubview(contentTitleLabel)
        contentTitleLabel.frame = CGRect(x: 16, y: 376, width: self.view.frame.width-32, height: 32)
        contentTitleLabel.text = "Magazine Title"
        contentTitleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        
        //Q.MARK -- Behavior -- isHighlighted (눌렀을 때) && isEnabled (인터렉션)
        contentTitleLabel.isUserInteractionEnabled = true // default is false
        contentTitleLabel.isHighlighted = true
        contentTitleLabel.highlightedTextColor = UIColor.white
        contentTitleLabel.clearsContextBeforeDrawing = true
        contentTitleLabel.isHidden = false // default false
        contentTitleLabel.isOpaque = true
        
        
        // MARK -- Generate Magazine Contents Module > ImageView > contentTitleLabel > contentSummaryLabel
        let contentSummaryLabel: UILabel = UILabel()
        contentModuleView.addSubview(contentSummaryLabel)
        contentSummaryLabel.frame = CGRect(x: 16, y: 402, width: self.view.frame.width-32, height: 110)
        contentSummaryLabel.text = "Introducing The Kinfolk Entrepreneur! Our latest book meets over 40 international entrepreneurs who offer tips, advice and inspiration for anyone hoping to forge their own professional path. Available to order at kinfolk.com/entrepreneur. Published by @artisan_books."
        
        //MARK -- UILabel.attributedText : lineBreakMode, textAlignment, lines
        //Q.MARK -- Attributed String : NSAttributedStringKey
        let stringValue = "Introducing The Kinfolk Entrepreneur! Our latest book meets over 40 international entrepreneurs who offer tips, advice and inspiration for anyone hoping to forge their own professional path. Available to order at kinfolk.com/entrepreneur. Published by @artisan_books."
        let attrString = NSMutableAttributedString(string: stringValue)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3 // change line spacing between paragraph
        paragraphStyle.minimumLineHeight = 0 // change line spacing between each line
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: stringValue.characters.count))
        contentSummaryLabel.attributedText = attrString
        
        //Q.MARK -- attrubutedText
        contentSummaryLabel.lineBreakMode = .byTruncatingTail
        // byTruncatingTail is default
        //byCharWrapping, byClipping, byTruncatingHead, byWordWrapping, byTruncatingMiddle
        contentSummaryLabel.allowsDefaultTighteningForTruncation = false // The default is false.
        contentSummaryLabel.textAlignment = .left
        contentSummaryLabel.numberOfLines = 6
        contentSummaryLabel.isEnabled = false // This property determines only how the label is drawn. Disabled text is dimmed somewhat to indicate it is not active. This property is set to true by default.
    
        //Q.MARK -- adjustsFontSizeToFitWidth == AutoShrink
        contentSummaryLabel.adjustsFontSizeToFitWidth = true
        contentSummaryLabel.minimumScaleFactor = 6
        
        /*Normally, the label text is drawn with the font you specify in the font property.
         If this property is set to true, and the text in the text property exceeds the label’s bounding rectangle, the label reduces the font size until the string fits or the minimum font scale is reached. The default value for this property is false. If you change it to true, be sure that you also set an appropriate minimum font scale by modifying the minimumScaleFactor property.*/
        
        //Q.MARK -- semantic: Unspecified(default), playback, spatial, force left to right
        contentSummaryLabel.semanticContentAttribute = .spatial
    
    
        //MARK -- Content Read Buttom
        let contentReadBtn: UIButton = UIButton(type: UIButtonType.system)// init 할 때만 type 선정 가능, 기본은 custom type
        contentModuleView.addSubview(contentReadBtn)
        contentReadBtn.setTitle("Read More", for: UIControlState.normal) // 버튼 내용
        contentReadBtn.setTitleColor(UIColor.black, for: UIControlState.normal) // 버튼 내용
        contentReadBtn.backgroundColor = #colorLiteral(red: 1, green: 0.7122342587, blue: 0, alpha: 1)
        contentReadBtn.frame = CGRect(x: contentModuleView.frame.width-116, y: contentModuleView.frame.height-15, width: 100, height: 30)
        contentReadBtn.addTarget(self, action: #selector(ViewController.contentReadBtnClick(_:)), for: UIControlEvents.touchUpInside)
        
        
        let homeBtn: UIButton = UIButton(type: UIButtonType.system)
        gnbView.addSubview(homeBtn)
        homeBtn.setTitle("Home", for: UIControlState.normal)
        homeBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        homeBtn.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        homeBtn.frame = CGRect(x: gnbView.frame.width-116, y: view.frame.origin.y+36, width: 100, height: 20)
        homeBtn.addTarget(self, action: #selector(ViewController.goHome), for: UIControlEvents.touchUpInside)
        
    }
    
    // MARK -- Read Button Click Enum Cases
    var titleCase = titleChangeCase.on
    enum titleChangeCase {
        case on
        case off
    }
    
    @objc func contentReadBtnClick(_ sender: UIButton) {
        switch titleCase {
        case .on:
        contentTitleLabel.text = "Want to read more?"
        titleCase = .off
        case .off:
        contentTitleLabel.text = "Magazine Title"
        titleCase = .on
        }
    }
    
    //MARK -- Home Button Click Enum Cases
    var logoSizeCase = LogoSize.on
    enum LogoSize {
        case on
        case off
    }
    
    @objc func goHome(_ sender: UIButton) {
        switch logoSizeCase {
        case .on:
            logoLabel.text = "Kinfolk is Good"
            logoSizeCase = .off
        case .off:
            logoLabel.text = "Kinfolk"
            logoSizeCase = .on
        }
        
    }

}

