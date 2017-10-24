//
//  RoundButton.swift
//  1018_Fanxy
//
//  Created by 김기윤 on 18/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class RoundButton: UIButton {
    // MARK: - StoryBoard에서 활용할 때 깨워야하는 init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 16
        self.layer.borderColor = self.tintColor.cgColor
        self.layer.borderWidth = 1
    }
}
