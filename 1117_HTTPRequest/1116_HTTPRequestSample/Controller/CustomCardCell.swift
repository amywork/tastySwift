//
//  CustomCardCell.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class CustomCardCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    
    var data: CardData? {
        willSet {
            nameLabel.text = newValue?.title
            postTextView.text = newValue?.content
            if let url = newValue?.imgCoverUrl {
                DispatchQueue.main.async {  [weak self] in
                    self?.imgView.loadImgData(url)
                }
            }
        }
    }
    
}

var cache: [String:Data] = [:]

extension UIImageView {
    
    func loadImgData(_ urlString: String) {
        if cache.keys.contains(urlString) {
            let data = cache[urlString]!
            self.image = UIImage(data: data)
        }else {
            DispatchQueue.global().sync {
                if let data = try? Data(contentsOf: URL(string: urlString)!) {
                    DispatchQueue.main.async { [weak self] in
                        self？.image = UIImage(data: data)
                    }
                    cache.updateValue(data, forKey: urlString)
                }
            }
        }
    }
    
}
