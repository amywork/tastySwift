//
//  SampleView.swift
//  DataModelSample2
//
//  Created by youngmin joo on 2017. 10. 16..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit



class SampleView: UIView {
    var name:String
    
    
    ///////클러저를 사용한 저장 프로퍼티 초기화
    let nameLBC:()->UILabel = {
        let lb:UILabel = UILabel()
        lb.textColor = .red
        lb.textAlignment = .center
        return lb
    }
    func test()
    {
        let nameLb:UILabel = nameLBC()
    }
    ///////////////////////////////////
    
    let nameLb:UILabel = {
        let lb:UILabel = UILabel()
        lb.textColor = .red
        lb.textAlignment = .center
        return lb
    }()
    
    
    override func awakeFromNib() {
        
    }
    
    
    
    ///////////initalization Sample///////////
    override init(frame: CGRect) {
        self.name = ""
        
        super.init(frame:frame)
    }
    
    
    convenience init(name:String)
    {
        self.init(frame:CGRect(x:0,y:0,width:100,height:100))
        
        self.name = name
    }
    
    convenience init(age:Int)
    {
        self.init(name:"joo")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
