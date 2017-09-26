//
//  ContentModule.swift
//  0925_UIViewPractice
//
//  Created by 김기윤 on 26/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
import Foundation

class ContentModuleView {

    // Create Content Module Function
    func createContentModule(mainView: UIView){
        
        // MARK -- Generate Magazine Contents Module
        let contentModuleView: UIView = UIView()
        mainView.addSubview(contentModuleView)
        contentModuleView.frame = CGRect(x: 0, y: 58, width: mainView.frame.width, height: 534)
        contentModuleView.backgroundColor = UIColor.lightGray
        contentModuleView.alpha = 1
        // MARK -- subview clipping?
        contentModuleView.clipsToBounds = true
        contentModuleView.autoresizesSubviews = true
        
        
        // MARK -- Generate Magazine Contents Top & Bottom Background Module View
        let contentModuleHalfTopView: UIView = UIView()
        contentModuleView.addSubview(contentModuleHalfTopView)
        contentModuleHalfTopView.backgroundColor = UIColor.white
        contentModuleHalfTopView.frame = CGRect(x: 0, y: 0, width: contentModuleView.frame.width, height: contentModuleView.frame.height/2)
        
        let contentModuleHalfBottomView: UIView = UIView()
        contentModuleView.addSubview(contentModuleHalfBottomView)
        contentModuleHalfBottomView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        contentModuleHalfBottomView.frame = CGRect(x: 0, y: contentModuleView.frame.height/2, width: contentModuleView.frame.width, height: contentModuleView.frame.height/2)
        
        
        // MARK -- Generate Magazine Contents Module -- ImageView
        let contentImageView: UIImageView = UIImageView()
        contentModuleView.addSubview(contentImageView)
        contentImageView.frame = CGRect(x: 8, y: 8, width: 359, height: 359)
        contentImageView.image = UIImage(named: "fritzHansen_04.jpg")
        contentImageView.contentMode = UIViewContentMode.scaleAspectFill
        // MARK -- image가 isHighlighted (눌렀을 때)
        contentImageView.isHighlighted = true
        contentImageView.highlightedImage = UIImage(named: "fritzHansen_02.jpg")
        contentImageView.isUserInteractionEnabled = true
        
        // MARK -- Generate Magazine Contents Module > ImageView > contentTitleLabel
        let contentTitleLabel: UILabel = UILabel()
        contentModuleView.addSubview(contentTitleLabel)
        contentTitleLabel.frame = CGRect(x: 16, y: 376, width: mainView.frame.width-32, height: 32)
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
        contentSummaryLabel.frame = CGRect(x: 16, y: 410, width: mainView.frame.width-32, height: 110)
        
        //MARK -- UILabel.attributedText : lineBreakMode, textAlignment, lines
        let stringValue = "Introducing The Kinfolk Entrepreneur! Our latest book meets over 40 international entrepreneurs who offer tips, advice and inspiration for anyone hoping to forge their own professional path. Available to order at kinfolk.com/entrepreneur. Published by @artisan_books."
        makeContentParagraphStyle(contentStr: stringValue)
        contentSummaryLabel.lineBreakMode = .byTruncatingMiddle
        contentSummaryLabel.allowsDefaultTighteningForTruncation = true
        contentSummaryLabel.textAlignment = .left
        contentSummaryLabel.numberOfLines = 6
        contentSummaryLabel.isEnabled = false
        //Q.MARK -- adjustsFontSizeToFitWidth == AutoShrink?
        contentSummaryLabel.adjustsFontSizeToFitWidth = true
        contentSummaryLabel.minimumScaleFactor = 6
        //Q.MARK -- semantic: Unspecified(default), playback, spatial, force left to right
        contentSummaryLabel.semanticContentAttribute = .spatial
        //Q.MARK -- Attributed String을 만드는 방법: line spacing

    }

    func makeContentParagraphStyle(contentStr: String) {
        let stringValue = contentStr
        let attrString = NSMutableAttributedString(string: stringValue)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        paragraphStyle.minimumLineHeight = 0
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: stringValue.characters.count))
    }
    
    func makeiOSColorPalette() {
        
    }
}
