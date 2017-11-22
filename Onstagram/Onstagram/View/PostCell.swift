//
//  PostCell.swift
//  Onstagram
//
//  Created by 김기윤 on 22/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var contentsTextView: UITextView!
    
    var postData: PostModel? {
        didSet {
            self.contentsTextView.text = postData?.contents
            
            if let url = postData?.imgUrl {
                self.postImageView.loadImage(URLstring: url, completion: { (data) in
                    print("cell image data url 성공")
                })
            }
            
            if let image = postData?.image {
                self.postImageView.image = image
            }
            
        }
    }
    
    // 나중에 Estimated Cell Size 만들 때 필요
    static var cellFromNib: PostCell {
        guard let cell = Bundle.main.loadNibNamed("PostCell", owner: nil, options: nil)?.first as? PostCell else {
            return PostCell()
        }
        return cell
    }
    
    
}
