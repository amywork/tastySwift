//
//  ViewController.swift
//  0925_UIViewPractice
//
//  Created by 김기윤 on 25/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//  UIImageView.image (image는 instance)
//  let newImgV = UIImageview(frame: CGRect)
//  newImgV.image = UIImage(named: "~.png")
//  UILabel.text (text는 instance)
//  newImgV.contentMode = UIViewContentMode.scaleAspectFit
//   -> contentMode (UIView의 속성)
//  UIView.frame = CGRect()
//  UIFont.systemFont(ofSize: ) ~ UIFont 문서 살펴보기 (자간, 장평)
//  UILabel.attributedText: URL, Bold 등의 처리 가능


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK -- Generate Kinfolk Logo
        let logoLabel: UILabel = UILabel(frame: CGRect(x: 16, y: 20, width: self.view.frame.width-32, height: 20))
        logoLabel.text = "Kinfolk Magazine"
        logoLabel.font = UIFont.systemFont(ofSize: 16)
        logoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        //위와 아래의 차이점은?
        logoLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        //UIFont.Weight : ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
        // MARK -- Custom Font type은 어떻게 설정하나요?
        logoLabel.textColor = UIColor.black
        logoLabel.textAlignment = .left
        logoLabel.shadowColor = UIColor.darkGray
    
    
        // MARK -- Generate Magazine Contents Module
        let contentModuleView: UIView = UIView()
        contentModuleView.frame = CGRect(x: 0, y: 57, width: self.view.frame.width, height: 534)
        contentModuleView.backgroundColor = UIColor.darkGray
        contentModuleView.alpha = 0.5
        
        let contentImageView: UIImageView = UIImageView()
        contentModuleView.addSubview(contentImageView)
        
        let contentTitleLabel: UILabel = UILabel()
        contentTitleLabel.bounds = .init(x: 0, y: 65, width: self.view.frame.width, height: 24)
        contentModuleView.addSubview(contentTitleLabel)
        contentTitleLabel.text = "Magazine Title"
        
        let contentSummaryLabel: UILabel = UILabel()
        contentModuleView.addSubview(contentSummaryLabel)
        contentSummaryLabel.frame = CGRect(x: 16, y: 406, width: self.view.frame.width-32, height: 110)
        contentSummaryLabel.text = "Introducing The Kinfolk Entrepreneur! Our latest book meets over 40 international entrepreneurs who offer tips, advice and inspiration for anyone hoping to forge their own professional path. Available to order at kinfolk.com/entrepreneur. Published by @artisan_books."
        //MARK -- UILabel.attributedText : lineBreakMode, textAlignment, lines
        contentSummaryLabel.lineBreakMode = .byCharWrapping
        contentSummaryLabel.textAlignment = .left
        contentSummaryLabel.numberOfLines = 3
       
        //
    }


}

