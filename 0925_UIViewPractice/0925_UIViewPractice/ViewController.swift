//
//  ViewController.swift
//  0925_UIViewPractice
//
//  Created by 김기윤 on 25/09/2017.
//  Copyright © 2017 younari. All rights reserved.

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK -- Generate Kinfolk Logo
        let logoLabel: UILabel = UILabel(frame: CGRect(x: 16, y: 32, width: self.view.frame.width-32, height: 20))
        logoLabel.text = "Kinfolk Magazine"
        logoLabel.textAlignment = .left
        logoLabel.font = UIFont.systemFont(ofSize: 16) // UIFont.font는 Instance
        logoLabel.textColor = UIColor.lightGray
        // Q.MARK -- font Weight 주는 아래 두가지 방식의 차이는 무엇인가요?
        logoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        logoLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        //UIFont.Weight : ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
        // Q.MARK -- Custom Font type은 어떻게 설정하나요?, 예를 들어 구글 폰트 임베드 하고 싶을 때?
        logoLabel.textColor = UIColor.black //  logoLabel.shadowColor = UIColor.darkGray
        // Q.MARK -- addSubview 실행 위치 상관있나요?
        self.view.addSubview(logoLabel)
    
        
        // MARK -- Generate Magazine Contents Module
        let contentModuleView: UIView = UIView()
        self.view.addSubview(contentModuleView)
        contentModuleView.frame = CGRect(x: 0, y: 58, width: self.view.frame.width, height: 534)
        contentModuleView.backgroundColor = UIColor.lightGray
        contentModuleView.alpha = 1
        contentModuleView.clipsToBounds = true // subview clipping?
        contentModuleView.autoresizesSubviews = true
        
        // MARK -- Generate Magazine Contents Module > ImageView
        let contentImageView: UIImageView = UIImageView()
        contentModuleView.addSubview(contentImageView)
        //Q.MARK -- 상위뷰 표현 어떻게?
        contentImageView.frame = CGRect(x: 8, y: 8, width: 359, height: 359)
        contentImageView.image = UIImage(named: "fritzHansen_04.jpg")  // UIImageView.image (image는 instance)
        contentImageView.contentMode = UIViewContentMode.scaleAspectFill // contentMode (UIView의 속성)
        //Q.MARK -- image가 isHighlighted 되었다는 의미는 무엇?
        contentImageView.isHighlighted = true
        contentImageView.highlightedImage = UIImage(named: "fritzHansen_02.jpg")
        contentImageView.isUserInteractionEnabled = true
        
        // MARK -- Generate Magazine Contents Module > ImageView > contentTitleLabel
        let contentTitleLabel: UILabel = UILabel()
        contentModuleView.addSubview(contentTitleLabel)
        contentTitleLabel.frame = CGRect(x: 16, y: 376, width: self.view.frame.width-32, height: 32)
        contentTitleLabel.text = "Magazine Title"
        contentTitleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        //Q.MARK -- Behavior -- isHighlighted && isEnabled의 차이?
        contentTitleLabel.isUserInteractionEnabled = true // default is false
        contentTitleLabel.isHighlighted = true
        contentTitleLabel.highlightedTextColor = UIColor.white
        contentTitleLabel.clearsContextBeforeDrawing = true
        contentTitleLabel.isHidden = false // default false
        contentTitleLabel.isOpaque = true
        
        
        // MARK -- Generate Magazine Contents Module > ImageView > contentTitleLabel > contentSummaryLabel
        let contentSummaryLabel: UILabel = UILabel()
        contentModuleView.addSubview(contentSummaryLabel)
        contentSummaryLabel.frame = CGRect(x: 16, y: 410, width: self.view.frame.width-32, height: 110)
        contentSummaryLabel.text = "Introducing The Kinfolk Entrepreneur! Our latest book meets over 40 international entrepreneurs who offer tips, advice and inspiration for anyone hoping to forge their own professional path. Available to order at kinfolk.com/entrepreneur. Published by @artisan_books."
        //MARK -- UILabel.attributedText : lineBreakMode, textAlignment, lines
        //Q.MARK -- attrubutedText 쓰는 법?
        contentSummaryLabel.lineBreakMode = .byTruncatingMiddle // byTruncatingTail is default
        //byCharWrapping, byClipping, byTruncatingHead, byWordWrapping, byTruncatingMiddle
        contentSummaryLabel.allowsDefaultTighteningForTruncation = true // The default is false.
        contentSummaryLabel.textAlignment = .left
        contentSummaryLabel.numberOfLines = 6
        //Q.MARK -- isEnabled의 정확한 의미? (상품 품절 같은거 표시?)
        contentSummaryLabel.isEnabled = false // This property determines only how the label is drawn. Disabled text is dimmed somewhat to indicate it is not active. This property is set to true by default.
        //Q.MARK -- adjustsFontSizeToFitWidth == AutoShrink?
        contentSummaryLabel.adjustsFontSizeToFitWidth = true
        contentSummaryLabel.minimumScaleFactor = 6
        /*Normally, the label text is drawn with the font you specify in the font property.
         If this property is set to true, and the text in the text property exceeds the label’s bounding rectangle,
         the label reduces the font size until the string fits or the minimum font scale is reached.
         The default value for this property is false. If you change it to true,
         be sure that you also set an appropriate minimum font scale by modifying the minimumScaleFactor property.*/
        //Q.MARK -- semantic: Unspecified(default), playback, spatial, force left to right
        contentSummaryLabel.semanticContentAttribute = .spatial
        
        
       
    }


}

