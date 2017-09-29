//
//  menuCell.swift
//  0929_TableView
//
//  Created by 김기윤 on 29/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class menuCell: UITableViewCell {
    
    // 클래스를 만드는 두가지 방법: Class 파일에 선언 or Stroyboard 를 통함(Nib)
    // ViewController는 viewDidLoad()가 진입점, storyBoard는 awakeFromNib
    // awakeFromNib는 스토리보드를 통해 UI를 만들 때의 진입점이라고 생각하면 된다.
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var bgImgView: UIImageView?
    
    func createView() {
        bgImgView = UIImageView()
        self.addSubview(bgImgView!)
    }
    
    func setImageName(name: String) {
        bgImgView?.image = UIImage(named: name)
    }
    
    func updateLayout() {
        bgImgView?.frame = self.bounds //menuCell의 인스턴스
        bgImgView?.contentMode = .scaleAspectFit
    }
    
    //menuCell의 인스턴스가 레이아웃을 정리할 때 프레임을 알아서 바꿔주라는 의미: layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }

}
