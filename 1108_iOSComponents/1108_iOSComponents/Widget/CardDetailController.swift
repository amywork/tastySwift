//
//  CardDetailController.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class CardDetailController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var data: CardData?
    
    @IBAction func didTapEditPhotoBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTapSaveBtn(_ sender: UIButton) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = self.data {
            nameLabel.text = data.cardName
            if let name = data.cardImgName {
                self.imgView.image = UIImage(named: name)
            }
            if let data = data.imgData {
                self.imgView.image = UIImage(data: data)
            }
        }
    }

}
