//
//  ViewController.swift
//  0925_UIViewPractice
//
//  Created by 김기윤 on 25/09/2017.
//  Copyright © 2017 younari. All rights reserved.

import UIKit
// protocol 추가 : UITextFieldDelegate
class ViewController: UIViewController, UITextFieldDelegate, UITextInputTraits {

    var logoLabel: UILabel = UILabel()
    var contentTitleLabel: UILabel = UILabel()
    var messageLabel = UILabel()
    var sendMsgTxtField = UITextField()
    var titleCase = TitleCase.on
    enum TitleCase {
        case on
        case off
    }
    var logoAnimatedCase = LogoAnimateCase.on
    enum LogoAnimateCase {
        case on
        case off
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gnbView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        self.view.addSubview(gnbView)
        
        let magazineFooterView: UIView = UIView()
        self.view.addSubview(magazineFooterView)
        magazineFooterView.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.9)
        magazineFooterView.frame = CGRect(x: 0, y:view.frame.size.height-100, width: view.frame.size.width, height: 100)
        
        // MARK -- Generate Kinfolk Logo
        logoLabel = UILabel(frame: CGRect(x: 16, y: 36, width: self.view.frame.width-32, height: 20))
        // MARK -- addSubview의 위치는 상관 없으나, 그래도 변수 선언하고 바로 추가하기
        gnbView.addSubview(logoLabel)
        
        logoLabel.text = "Kinfolk Magazine"
        logoLabel.textAlignment = .left
        logoLabel.font = UIFont.systemFont(ofSize: 16) // UIFont.font는 Instance
        logoLabel.textColor = UIColor.darkGray // logoLabel.shadowColor = UIColor.darkGray
        
		// MARK -- font Weight
        //UIFont.Weight : ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
        logoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        logoLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy)
	    // Q.MARK -- Custom Font type
		// logoLabel.font = UIFont(name: "Font Name", size: 16)
        
   
        // MARK -- Generate Magazine Contents Module
        let contentModuleView: UIView = UIView()
        self.view.addSubview(contentModuleView)
        contentModuleView.frame = CGRect(x: 0, y: 60, width: self.view.frame.width, height: 534)
        contentModuleView.backgroundColor = UIColor.lightGray
        contentModuleView.alpha = 1
        
        // MARK -- subview clipping
        contentModuleView.clipsToBounds = false
        contentModuleView.autoresizesSubviews = true
        
        // MARK -- Generate Module Background Contents Top & Bottom View
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
        
        // MARK -- 상위뷰 표현 -- 상위뷰의 이름을 쓰기
	    contentImageView.frame = CGRect(x: 8, y: 8, width: 359, height: 359)
        contentImageView.image = UIImage(named: "fritzHansen_04.jpg")  // UIImageView.image (image는 instance)
        contentImageView.contentMode = UIViewContentMode.scaleAspectFill // contentMode (UIView의 속성)
        
        // MARK -- image가 isHighlighted (눌렀을 때)
        contentImageView.isHighlighted = true
        contentImageView.highlightedImage = UIImage(named: "fritzHansen_02.jpg")
        contentImageView.isUserInteractionEnabled = true // default value of this property to false.
        
        // MARK -- Generate Magazine Contents Module > ImageView > contentTitleLabel
        contentModuleView.addSubview(contentTitleLabel)
        contentTitleLabel.frame = CGRect(x: 16, y: 376, width: self.view.frame.width-32, height: 32)
        contentTitleLabel.text = "Magazine Title"
        contentTitleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        
        // MARK -- Behavior -- isHighlighted (눌렀을 때) && isEnabled (인터렉션)
        contentTitleLabel.isUserInteractionEnabled = true // default is false
        contentTitleLabel.isHighlighted = true
        contentTitleLabel.highlightedTextColor = UIColor.white
        contentTitleLabel.clearsContextBeforeDrawing = true
        contentTitleLabel.isHidden = false // default false
        contentTitleLabel.isOpaque = true
        
        // MARK -- Generate Magazine Contents Module -> contentSummaryLabel
        let contentSummaryLabel: UILabel = UILabel()
        contentModuleView.addSubview(contentSummaryLabel)
        contentSummaryLabel.frame = CGRect(x: 16, y: contentImageView.frame.height + contentTitleLabel.frame.height + 16, width: self.view.frame.width-32, height: 110)
        
        // MARK -- UILabel.attributedText : lineBreakMode, textAlignment, lines
        // MARK -- Attributed String : NSAttributedStringKey
        let stringValue = "Introducing The Kinfolk Entrepreneur! Our latest book meets over 40 international entrepreneurs who offer tips, advice and inspiration for anyone hoping to forge their own professional path. Available to order at kinfolk.com/entrepreneur. Published by @artisan_books."
        let attrString = NSMutableAttributedString(string: stringValue)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5 // change line spacing between paragraph
        paragraphStyle.minimumLineHeight = 5 // change line spacing between each line
        
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: stringValue.characters.count))
        
        attrString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.orange, range: NSRange.init(location: 11, length: 26))
        contentSummaryLabel.attributedText = attrString
        
        // MARK -- lineBreakMode // byTruncatingTail is default
        //byCharWrapping, byClipping, byTruncatingHead, byWordWrapping, byTruncatingMiddle
        contentSummaryLabel.lineBreakMode = .byTruncatingTail
        contentSummaryLabel.allowsDefaultTighteningForTruncation = false // The default is false.
        contentSummaryLabel.textAlignment = .left
        contentSummaryLabel.numberOfLines = 0
        contentSummaryLabel.isEnabled = false // This property determines only how the label is drawn. Disabled text is dimmed somewhat to indicate it is not active. This property is set to true by default.
    
        // MARK -- adjustsFontSizeToFitWidth == AutoShrink
        contentSummaryLabel.adjustsFontSizeToFitWidth = true
        contentSummaryLabel.minimumScaleFactor = 12
        /*Normally, the label text is drawn with the font you specify in the font property.
         If this property is set to true, and the text in the text property exceeds the label’s bounding rectangle, the label reduces the font size until the string fits or the minimum font scale is reached. The default value for this property is false. If you change it to true, be sure that you also set an appropriate minimum font scale by modifying the minimumScaleFactor property.*/
        
        // MARK -- semantic: Unspecified(default), playback, spatial, force left to right
        contentSummaryLabel.semanticContentAttribute = .spatial
    
        //MARK -- Content Read Buttom
        let readMoreBtn: UIButton = UIButton(type: .custom)
        // init 할 때만 type 선정 가능, 기본은 custom type -- .systme, .custom,...
        contentModuleView.addSubview(readMoreBtn)
        readMoreBtn.setTitle("Read More", for: UIControlState.normal) // 버튼 내용
        readMoreBtn.setTitleColor(UIColor.black, for: .normal) // 버튼 내용
        readMoreBtn.backgroundColor = #colorLiteral(red: 1, green: 0.7122342587, blue: 0, alpha: 1)
        readMoreBtn.frame = CGRect(x: contentModuleView.frame.width-116, y: contentImageView.frame.height, width: 100, height: 30)
        readMoreBtn.addTarget(self, action: #selector(ViewController.handleTitleChange), for: UIControlEvents.touchUpInside)
        
        //MARK -- Hello Button
        let logoAnimateBtn: UIButton = UIButton(type: UIButtonType.system)
        gnbView.addSubview(logoAnimateBtn)
        logoAnimateBtn.backgroundColor = UIColor.clear
        logoAnimateBtn.frame = CGRect(x: 16, y: 36, width: self.view.frame.width-32, height: 20)
        logoAnimateBtn.addTarget(self, action: #selector(ViewController.goHome), for: UIControlEvents.touchUpInside)


        // UITextField 는 1줄 입력이 default
        sendMsgTxtField = UITextField(frame: CGRect(x: 0, y: view.frame.size.height-50, width: view.frame.size.width, height: 50 ))
        self.view.addSubview(sendMsgTxtField)
        sendMsgTxtField.borderStyle = .line
        sendMsgTxtField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sendMsgTxtField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        sendMsgTxtField.placeholder = "Kinfolk에게 의견을 보내주세요😊"
        /****UITextfield Protocol 채택 및 delegate 사용*****/
        sendMsgTxtField.delegate = self
        sendMsgTxtField.adjustsFontSizeToFitWidth = true
        sendMsgTxtField.minimumFontSize = 6
        sendMsgTxtField.clearsOnBeginEditing = true
        
        
        // OKButton
        let OKButton = UIButton(type: .system)
        self.view.addSubview(OKButton)
        OKButton.frame = CGRect(x: view.frame.size.width-80, y: view.frame.size.height-50, width: 80, height: 50)
        OKButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        OKButton.setTitle("OK", for: .normal)
        OKButton.setTitleColor(.white, for: .normal)
        OKButton.addTarget(self, action: #selector(ViewController.handlerOkBtn), for: .touchUpInside)
        
        
        // Label
        messageLabel = UILabel(frame: CGRect(x: 0, y: view.frame.size.height-80, width: contentModuleView.frame.size.width, height: 30))
        messageLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        view.addSubview(messageLabel)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMsgTxtField.resignFirstResponder() // 키보드를 내리는 아이
        return true
    }
    
    @objc func handlerOkBtn(_ sender : UIButton) {
        messageLabel.text = sendMsgTxtField.text
        sendMsgTxtField.text = ""
    }
    
    @objc func handleTitleChange(_ sender: UIButton) {
        switch titleCase {
        case .on:
        contentTitleLabel.text = "Want to read more?"
        titleCase = .off
        case .off:
        contentTitleLabel.text = "Magazine Title"
        titleCase = .on
        }
    }
    
    @objc func goHome(_ sender: UIButton) {
        switch logoAnimatedCase {
        case .on:
            logoLabel.text = "Kinfolk is Good"
            logoAnimatedCase = .off
        case .off:
            logoLabel.text = "Kinfolk Magazine"
            logoAnimatedCase = .on
        }
    }

}

