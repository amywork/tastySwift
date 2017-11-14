import UIKit

final class PostEditViewTextCell: UITableViewCell {
  fileprivate enum Font {
    static let textView = UIFont.systemFont(ofSize: 14)
  }

  fileprivate let textView = UITextView()

  var textDidChange: ((String?) -> Void)?

  // 1. 생성자
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.textView.font = Font.textView
    self.textView.delegate = self
    self.textView.isScrollEnabled = false
    self.contentView.addSubview(self.textView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // 2. 설정
  func configure(text: String?) {
    self.textView.text = text
    self.setNeedsLayout()
  }

  // 3. 레이아웃
  override func layoutSubviews() {
    super.layoutSubviews()
    self.textView.width = self.contentView.width
    self.textView.height = self.contentView.height
  }

  // 4. 크기
  class func height(width: CGFloat, text: String?) -> CGFloat {
    let minimumHeight = CGFloat(100)
    guard let text = text else { return minimumHeight }
    return max(text.size(width: width, font: Font.textView).height, minimumHeight)
  }
}

extension PostEditViewTextCell: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    self.textDidChange?(textView.text)
  }
}


















