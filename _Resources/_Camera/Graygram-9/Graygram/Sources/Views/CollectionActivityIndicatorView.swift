import UIKit

final class CollectionActivityIndicatorView: UICollectionReusableView {
  fileprivate let activityIndicatorView = UIActivityIndicatorView(
    activityIndicatorStyle: .gray
  )

  override init(frame: CGRect) {
    super.init(frame: frame)
    activityIndicatorView.startAnimating()
    self.addSubview(activityIndicatorView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    activityIndicatorView.centerX = self.width / 2
    activityIndicatorView.centerY = self.height / 2
  }
}
















