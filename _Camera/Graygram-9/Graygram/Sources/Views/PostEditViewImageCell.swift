// 미션:
// 1. photoView: UIImageView
// 2. configure(image: UIImage)
// 3. photoView가 셀에 꽉 차야 합니다.
// 4. class func height(width: CGFloat) -> CGFloat // 정사각형 크기 반환

import UIKit

final class PostEditViewImageCell: UITableViewCell {
  fileprivate let photoView = UIImageView()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(self.photoView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(image: UIImage) {
    self.photoView.image = image
    self.setNeedsLayout()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.photoView.width = self.contentView.width
    self.photoView.height = self.contentView.height
  }

  class func height(width: CGFloat) -> CGFloat {
    return width
  }
}




















