//
//  ExploreCell.swift
//  0930_ExploreTableView
//
//  Created by Kimkeeyun on 30/09/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class ExploreCell: UITableViewCell {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
        updateViewStyle()
    }
    
    var itemImg: UIImageView?
    var itemTitleLabel: UILabel?
    var itemDetailLabel: UILabel?
    var itemDecoView: UIView?
    
    func createView() {
        itemImg = UIImageView()
        itemTitleLabel = UILabel()
        itemDetailLabel = UILabel()
        itemDecoView = UIView()
        self.addSubview(itemImg!)
        self.addSubview(itemTitleLabel!)
        self.addSubview(itemDetailLabel!)
        self.addSubview(itemDecoView!)
    }
    
    func updateViewStyle() {
        itemTitleLabel?.text = "🔺 Product Name"
        itemTitleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        itemDetailLabel?.text = "Tea Egg is a functional tea infuser made of silicone and designed by the Danish design company Made by Makers. Tea Egg is quick to brew a warm cup of tea for those everyday cozy moments."
        itemDetailLabel?.numberOfLines = 0
        itemDetailLabel?.lineBreakMode = .byCharWrapping
        itemDetailLabel?.lineBreakMode = .byTruncatingTail
        itemDetailLabel?.font = UIFont.systemFont(ofSize: 13, weight: .light)
    }
    
    func setImgName(name: String) {
        guard let itemImg: UIImageView = itemImg else { return }
        itemImg.image = UIImage(named: name)
    }
        
    func updateLayout() {
        itemImg?.frame = CGRect(x: 16, y: 16, width: 100, height: self.bounds.height-32)
        itemImg?.contentMode = .scaleAspectFit
        itemTitleLabel?.frame = CGRect(x: 132, y: 16, width: 198, height: 22)
        itemDetailLabel?.frame = CGRect(x: 132, y: 40, width: 198, height: 50)
        itemDecoView?.frame = CGRect(x: 0, y: 0, width: 6, height: self.bounds.height)
    }
    
    //ExploreCell의 인스턴스가 레이아웃을 정리할 때 프레임을 알아서 바꿔주라는 의미: layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }

}
