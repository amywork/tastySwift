//
//  ViewController.swift
//  0928_UIScrollTable
//
//  Created by 김기윤 on 28/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class CardScrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var cardScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cardScrollView.contentSize = CGSize(width: cardScrollView.frame.size.width*10, height: cardScrollView.frame.size.height)

        var colors: [UIColor] = [#colorLiteral(red: 1, green: 0.1550967693, blue: 0.3156332672, alpha: 1), #colorLiteral(red: 1, green: 0.8060369492, blue: 0, alpha: 1), #colorLiteral(red: 0.2599990964, green: 0.8597032428, blue: 0.3661444783, alpha: 1), #colorLiteral(red: 0, green: 0.4624820948, blue: 1, alpha: 1), #colorLiteral(red: 0.5570569634, green: 0.5565271974, blue: 0.5783077478, alpha: 1), #colorLiteral(red: 0.3402141929, green: 0.3152036071, blue: 0.8540361524, alpha: 1), #colorLiteral(red: 1, green: 0.1550967693, blue: 0.3156332672, alpha: 1), #colorLiteral(red: 1, green: 0.5882255435, blue: 0, alpha: 1), #colorLiteral(red: 0.1577495635, green: 0.6642175913, blue: 0.8744296432, alpha: 1)]        
        for n in 0..<colors.count {
            let card = UIView()
            var offset: CGFloat {
                return 16 + (260*CGFloat(n)) + (16*2*CGFloat(n))
            }
            card.frame = CGRect(x: offset, y: 16, width: 260, height: cardScrollView.frame.size.height-32)
            card.backgroundColor = colors[n]
            card.layer.cornerRadius = 13
            cardScrollView.addSubview(card)
        }
        
    }
}
