import UIKit

final class FeedViewController: UIViewController {
  enum ViewMode {
    case card
    case tile
  }

  fileprivate var posts: [Post] = []
  fileprivate var nextURLString: String?
  fileprivate var isLoading: Bool = false
  fileprivate var viewMode: ViewMode = .card {
    didSet {
      switch self.viewMode {
      case .card:
        self.navigationItem.leftBarButtonItem = self.tileButtonItem
      case .tile:
        self.navigationItem.leftBarButtonItem = self.cardButtonItem
      }
      self.collectionView.reloadData()
    }
  }

  fileprivate let tileButtonItem = UIBarButtonItem(
    image: UIImage(named: "icon-tile"),
    style: .plain,
    target: nil,
    action: nil
  )
  fileprivate let cardButtonItem = UIBarButtonItem(
    image: UIImage(named: "icon-card"),
    style: .plain,
    target: nil,
    action: nil
  )

  fileprivate let refreshControl = UIRefreshControl()
  fileprivate let collectionView = UICollectionView(
    frame: .zero, // CGRect.zero
    collectionViewLayout: UICollectionViewFlowLayout() // CSS float과 비슷
  )

  init() {
    super.init(nibName: nil, bundle: nil)
    self.navigationItem.title = "Graygram" // (기본값: self.title)
    self.tabBarItem.title = "Feed" // (기본값: self.title)
    self.tabBarItem.image = UIImage(named: "tab-feed")
    self.tabBarItem.selectedImage = UIImage(named: "tab-feed-selected")

    self.tileButtonItem.target = self
    self.tileButtonItem.action = #selector(tileButtonItemDidTap)
    self.cardButtonItem.target = self
    self.cardButtonItem.action = #selector(cardButtonItemDidTap)

    self.navigationItem.leftBarButtonItem = self.tileButtonItem
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(
      PostCardCell.self,
      forCellWithReuseIdentifier: "cardCell"
    )
    collectionView.register(
      PostTileCell.self,
      forCellWithReuseIdentifier: "tileCell"
    )
    collectionView.register(
      CollectionActivityIndicatorView.self,
      forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
      withReuseIdentifier: "activityIndicatorView"
    )
    collectionView.dataSource = self
    collectionView.delegate = self

    refreshControl.addTarget(
      self,
      action: #selector(refreshControlDidChangeValue),
      for: .valueChanged
    )

    self.view.addSubview(collectionView)
    collectionView.addSubview(refreshControl)

    collectionView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.bottom.equalToSuperview()
      make.right.equalToSuperview()

      // (위와 같음) make.top.left.bottom.right.equalToSuperview()

      // (위와 같음) make.edges.equalToSuperview()
    }

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(postDidLike),
      name: .postDidLike,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(postDidUnlike),
      name: .postDidUnlike,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(postDidCreate),
      name: .postDidCreate,
      object: nil
    )

    fetchPosts(paging: .refresh)
  }

  func refreshControlDidChangeValue() {
    fetchPosts(paging: .refresh)
  }

  fileprivate func fetchPosts(paging: Paging) {
    guard !isLoading else { return }
    isLoading = true

    FeedService.feed(paging: paging) { response in
      self.isLoading = false
      self.refreshControl.endRefreshing()

      switch response.result {
      case .success(let feed):
        let newPosts = feed.posts ?? []
        switch paging {
        case .refresh:
          self.posts = newPosts
        case .next:
          self.posts += newPosts
        }
        self.nextURLString = feed.nextURLString
        self.collectionView.reloadData()

      case .failure(let error):
        print(error)
      }
    }
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.collectionViewLayout.invalidateLayout()
  }


  // MARK: Notifications

  func postDidLike(notification: Notification) {
    guard let postID = notification.userInfo?["postID"] as? Int else { return }
    // 미션: self.posts 배열에서 좋아요가 표시된 Post 정보 업데이트
    //   likeCount += 1
    //   isLiked = true
    // 힌트: struct는 '복제'

    // 방법 1 (map 사용)
    self.posts = self.posts.map { post in
      if post.id == postID {
        var newPost = post
        newPost.isLiked = true
        newPost.likeCount! += 1
        return newPost
      } else {
        return post
      }
    }

    // 방법 2 (index 사용)
    guard let index = self.posts.index(where: { $0.id == postID }) else { return }
    var newPost = self.posts[index]
    newPost.isLiked = true
    newPost.likeCount! += 1
    self.posts[index] = newPost
  }

  func postDidUnlike(notification: Notification) {
    guard let postID = notification.userInfo?["postID"] as? Int else { return }
    guard let index = self.posts.index(where: { $0.id == postID }) else { return }
    var newPost = self.posts[index]
    newPost.isLiked = false
    newPost.likeCount! -= 1
    self.posts[index] = newPost
  }

  func postDidCreate(notification: Notification) {
    guard let post = notification.userInfo?["post"] as? Post else { return }
    self.posts.insert(post, at: 0)
    self.collectionView.reloadData()
  }

  func tileButtonItemDidTap() {
    self.viewMode = .tile
  }

  func cardButtonItemDidTap() {
    self.viewMode = .card
  }
}

extension FeedViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return self.posts.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    switch self.viewMode {
    case .card:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "cardCell",
        for: indexPath
      ) as! PostCardCell
      let post = self.posts[indexPath.item]
      cell.configure(post: post, isMessageTrimmed: true)
      return cell

    case .tile:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "tileCell",
        for: indexPath
      ) as! PostTileCell
      let post = self.posts[indexPath.item]
      cell.configure(post: post)
      cell.didTap = {
        let viewController = PostViewController(postID: post.id)
        self.navigationController?.pushViewController(viewController, animated: true)
      }
      return cell
    }
  }

  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {
    return collectionView.dequeueReusableSupplementaryView(
      ofKind: UICollectionElementKindSectionFooter,
      withReuseIdentifier: "activityIndicatorView",
      for: indexPath
    )
  }
}


extension FeedViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let post = self.posts[indexPath.item]
    switch self.viewMode {
    case .card:
      return PostCardCell.size(
        width: collectionView.frame.size.width,
        post: post,
        isMessageTrimmed: true
      )

    case .tile:
      return PostTileCell.size(width: collectionView.width / 3)
    }
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForFooterInSection section: Int
  ) -> CGSize {
    // 더보기 요청이 불가능한 경우 (마지막 페이지에 도달)
    if self.nextURLString == nil && !self.posts.isEmpty {
      return .zero
    } else {
      return CGSize(width: collectionView.width, height: 44)
    }
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard scrollView.contentSize.height > 0 else { return }
    let contentOffsetBottom = scrollView.contentOffset.y + scrollView.height
    let isReachedBottom = contentOffsetBottom >= scrollView.contentSize.height - 300
    if let nextURLString = self.nextURLString, isReachedBottom {
      fetchPosts(paging: .next(nextURLString))
    }
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    switch self.viewMode {
    case .card:
      return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    case .tile:
      return UIEdgeInsets.zero
    }
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    switch self.viewMode {
    case .card: return 20
    case .tile: return 0
    }
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
}


















