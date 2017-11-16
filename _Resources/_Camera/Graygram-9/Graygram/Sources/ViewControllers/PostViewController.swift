import UIKit

final class PostViewController: UIViewController {
  fileprivate let postID: Int
  fileprivate var post: Post?

  // 미션:
  //   Post가 collectionView에 보이도록 해보세요.

  fileprivate let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )

  init(postID: Int) {
    self.postID = postID
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white

    self.collectionView.backgroundColor = .white
    self.collectionView.alwaysBounceVertical = true
    self.collectionView.register(PostCardCell.self, forCellWithReuseIdentifier: "postCell")
    self.collectionView.dataSource = self
    self.collectionView.delegate = self

    self.view.addSubview(self.collectionView)

    self.collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    self.fetchPost()
  }

  func fetchPost() {
    PostService.post(id: self.postID) { response in
      switch response.result {
      case .success(let post):
        self.post = post
        self.collectionView.reloadData()

      case .failure(let error):
        print("Post 로드 실패: \(error)")
      }
    }
  }
}

extension PostViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    if self.post == nil {
      return 0
    } else {
      return 1
    }
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCardCell
    if let post = self.post {
      cell.configure(post: post, isMessageTrimmed: false)
    }
    return cell
  }
}

extension PostViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    guard let post = self.post else { return .zero }
    return PostCardCell.size(
      width: collectionView.width,
      post: post,
      isMessageTrimmed: false
    )
  }
}
















