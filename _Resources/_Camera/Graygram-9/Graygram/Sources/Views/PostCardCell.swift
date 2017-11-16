import UIKit

final class PostCardCell: UICollectionViewCell {
  fileprivate enum Metric {
    static let avatarViewTop: CGFloat = 0
    static let avatarViewLeft: CGFloat = 10
    static let avatarViewSize: CGFloat = 30

    /// avatarView의 오른쪽 간격
    static let usernameLabelLeft: CGFloat = 10
    static let usernameLabelRight: CGFloat = 10

    static let pictureViewTop: CGFloat = 10

    static let likeButtonTop: CGFloat = 10
    static let likeButtonLeft: CGFloat = 10
    static let likeButtonSize: CGFloat = 20

    static let likeCountLabelLeft: CGFloat = 10
    static let likeCountLabelRight: CGFloat = 10

    static let messageLabelTop: CGFloat = 10
    static let messageLabelLeft: CGFloat = 10
    static let messageLabelRight: CGFloat = 10
  }

  fileprivate enum Font {
    static let usernameLabel = UIFont.boldSystemFont(ofSize: 13)
    static let likeCountLabel = UIFont.boldSystemFont(ofSize: 13)
    static let messageLabel = UIFont.systemFont(ofSize: 14)
  }

  /// 사용자 프로필 이미지 뷰
  fileprivate let avatarView = UIImageView()

  /// 사용자 이름 라벨
  fileprivate let usernameLabel = UILabel()

  fileprivate let pictureView = UIImageView()

  fileprivate let likeButton = UIButton()
  fileprivate let likeCountLabel = UILabel()

  fileprivate let messageLabel = UILabel()

  fileprivate var post: Post?
  fileprivate var isMessageTrimmed: Bool?


  // 1. 생성자

  override init(frame: CGRect) {
    super.init(frame: frame)

    // 1) 속성 초기화
    avatarView.backgroundColor = .gray
    avatarView.contentMode = .scaleAspectFill
    avatarView.clipsToBounds = true
    avatarView.layer.cornerRadius = Metric.avatarViewSize / 2

    usernameLabel.font = Font.usernameLabel
    usernameLabel.textColor = .black

    pictureView.backgroundColor = .gray

    likeButton.setBackgroundImage(#imageLiteral(resourceName: "icon-like"), for: .normal)
    likeButton.setBackgroundImage(#imageLiteral(resourceName: "icon-like-selected"), for: .selected)
    likeCountLabel.font = Font.likeCountLabel

    messageLabel.font = Font.messageLabel
    messageLabel.numberOfLines = 3

    // 2) addSubview하는 곳
    self.contentView.addSubview(avatarView)
    self.contentView.addSubview(usernameLabel)
    self.contentView.addSubview(pictureView)
    self.contentView.addSubview(likeButton)
    self.contentView.addSubview(likeCountLabel)
    self.contentView.addSubview(messageLabel)

    likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // 2. 설정

  func configure(post: Post, isMessageTrimmed: Bool) {
    self.post = post
    self.isMessageTrimmed = isMessageTrimmed
    avatarView.setImage(photoID: post.user.photoID, size: .tiny)
    usernameLabel.text = post.user.username
    pictureView.setImage(photoID: post.photoID, size: .large)
    likeButton.isSelected = post.isLiked
    likeCountLabel.text = "\(post.likeCount ?? 0)명이 좋아합니다."
    messageLabel.text = post.message
    messageLabel.numberOfLines = isMessageTrimmed ? 3 : 0
    setNeedsLayout()
  }


  // 3. 크기

  class func size(width: CGFloat, post: Post, isMessageTrimmed: Bool) -> CGSize {
    var height: CGFloat = 0

    height += Metric.avatarViewTop
    height += Metric.avatarViewSize

    height += Metric.pictureViewTop
    height += width // picture의 높이

    height += Metric.likeButtonTop
    height += Metric.likeButtonSize

    if let message = post.message, !message.isEmpty {
      let messageLabelWidth = width - Metric.messageLabelLeft - Metric.messageLabelRight
      height += Metric.messageLabelTop
      height += message.size(
        width: messageLabelWidth,
        font: Font.messageLabel,
        numberOfLines: isMessageTrimmed ? 3 : 0
      ).height
    }

    return CGSize(width: width, height: height)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    // avatar view
    avatarView.x = Metric.avatarViewLeft
    avatarView.y = Metric.avatarViewTop
    avatarView.width = Metric.avatarViewSize
    avatarView.height = Metric.avatarViewSize

    // username label
    usernameLabel.left = avatarView.right + Metric.usernameLabelLeft
    usernameLabel.sizeToFit()
    usernameLabel.width = min(
      usernameLabel.width,
      contentView.width - Metric.usernameLabelRight - usernameLabel.left
    )
    usernameLabel.centerY = avatarView.centerY

    // picture view
    pictureView.width = contentView.width
    pictureView.height = pictureView.width
    pictureView.top = avatarView.bottom + Metric.pictureViewTop

    // like button
    likeButton.width = Metric.likeButtonSize
    likeButton.height = Metric.likeButtonSize
    likeButton.left = Metric.likeButtonLeft
    likeButton.top = pictureView.bottom + Metric.likeButtonTop

    // like count label
    likeCountLabel.left = likeButton.right + Metric.likeCountLabelLeft
    likeCountLabel.sizeToFit()
    likeCountLabel.width = min(
      likeCountLabel.width,
      contentView.width - Metric.likeCountLabelRight - likeCountLabel.left
    )
    likeCountLabel.centerY = likeButton.centerY

    // message label
    messageLabel.top = likeButton.bottom + Metric.messageLabelTop
    messageLabel.left = Metric.messageLabelLeft
    messageLabel.width = contentView.width - Metric.messageLabelRight - messageLabel.left
    messageLabel.sizeToFit()

    // 한줄:  sizeToFit -> width 설정
    // 여러줄: width 설정 -> sizeToFit
  }

  func likeButtonDidTap() {
    guard let post = self.post else { return }
    guard let isMessageTrimmed = self.isMessageTrimmed else { return }
    if !likeButton.isSelected {
      var newPost = post
      newPost.isLiked = true
      newPost.likeCount! += 1
      self.configure(post: newPost, isMessageTrimmed: isMessageTrimmed)
      PostService.like(postID: post.id)
    } else {
      var newPost = post
      newPost.isLiked = false
      newPost.likeCount! -= 1
      self.configure(post: newPost, isMessageTrimmed: isMessageTrimmed)
      PostService.unlike(postID: post.id)
    }
  }
}















