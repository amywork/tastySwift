import UIKit

// 미션:
// - imageView: UIImage를 셀에 꽉 채워보세요.
// - configure(post: Post)
// - 크기는 정사각형을 반환하도록 해보세요.

final class PostTileCell: UICollectionViewCell {
  fileprivate let imageView = UIImageView()

  var didTap: (() -> Void)?

  // 1. 생성자
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.addSubview(self.imageView)

    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(contentViewDidTap)
    )
    self.contentView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // 2. 설정
  func configure(post: Post) {
    self.imageView.setImage(photoID: post.photoID, size: .medium)
  }

  // 3. 레이아웃
  override func layoutSubviews() {
    super.layoutSubviews()
    self.imageView.width = self.contentView.width
    self.imageView.height = self.contentView.height
  }

  // 4. 크기
  class func size(width: CGFloat) -> CGSize {
    return CGSize(width: width, height: width) // 정사각형
  }

  func contentViewDidTap() {
    self.didTap?()
  }
}





















