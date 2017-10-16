//
//  SomeView.swift
//  1016_DataModel
//
//  Created by 김기윤 on 16/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class SomeView: UIView {

    // SomeView의 프로퍼티
    var name:String
    
    // SomeView의 부모 class가 요구하는 required initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // designated initializer
    override init(frame: CGRect) {
        // SomeView의 프로퍼티를 초기화하는 동시에,
        self.name = ""
        // 상속을 받았으므로 부모 클래스의 Designated initializer를 호출하며 frame 초기화
        super.init(frame: frame)
    }
    
    // convenience initializer: name 값을 받으면서 초기화 하기 위함
    convenience init(name: String) {
        // 자신의 designated initializer 호출
        self.init(frame: CGRect(x:0,y:0,width:10,height:10))
        // SomeView의 프로퍼티 초기화
        self.name = name
    }
    
    let nameLabelClosure: () -> UILabel = {
        let lb = UILabel()
        lb.text = "Today"
        lb.textColor = .black
        lb.textAlignment = .center
        return lb
    }
    
    var nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Today"
        lb.textColor = .black
        lb.textAlignment = .center
        return lb
    }()
    
    override func awakeFromNib() {
        let label = nameLabelClosure()
        self.addSubview(nameLabel)
        self.addSubview(label)
    }

}
