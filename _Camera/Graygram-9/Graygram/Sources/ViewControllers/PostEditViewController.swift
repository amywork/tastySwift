import UIKit

// 미션:
// 1. PostEditViewController 클래스 정의
// 2. UITableView를 화면에 꽉차게 보이도록 해보세요.
//    - tableView.backgroundColor = .blue
//    - didFinishCropping 클로저에서 PostEditViewController를 띄워서 확인해도 OK

// 미션:
//   PostEditViewImageCell이 화면에 보이도록 해보세요.

final class PostEditViewController: UIViewController {
  fileprivate let cancelButtonItem = UIBarButtonItem(
    barButtonSystemItem: .cancel,
    target: nil,
    action: nil
  )
  fileprivate let doneButtonItem = UIBarButtonItem(
    barButtonSystemItem: .done,
    target: nil,
    action: nil
  )
  fileprivate let progressView = UIProgressView()
  fileprivate let tableView = UITableView(frame: .zero, style: .grouped)

  fileprivate let image: UIImage
  fileprivate var text: String?

  // 미션:
  // 1. cancelButtonItem과 doneButtonItem을 속성으로 정의
  // 2. 네비게이션 바 왼쪽과 오른쪽에 각각을 추가

  init(image: UIImage) {
    self.image = image
    super.init(nibName: nil, bundle: nil)

    self.cancelButtonItem.target = self
    self.cancelButtonItem.action = #selector(cancelButtonItemDidTap)
    self.navigationItem.leftBarButtonItem = self.cancelButtonItem

    self.doneButtonItem.target = self
    self.doneButtonItem.action = #selector(doneButtonItemDidTap)
    self.navigationItem.rightBarButtonItem = self.doneButtonItem

    self.progressView.isHidden = true

    self.tableView.register(PostEditViewImageCell.self, forCellReuseIdentifier: "imageCell")
    self.tableView.register(PostEditViewTextCell.self, forCellReuseIdentifier: "textCell")
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.keyboardDismissMode = .interactive
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(self.tableView)
    self.view.addSubview(self.progressView)

    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    self.progressView.snp.makeConstraints { make in
      make.top.equalTo(self.topLayoutGuide.snp.bottom)
      make.left.right.equalToSuperview()
    }

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillChangeFrame),
      name: .UIKeyboardWillChangeFrame,
      object: nil
    )
  }

  func keyboardWillChangeFrame(notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
    guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
    let keyboardVisibleHeight = UIScreen.main.bounds.height - keyboardFrame.y
    UIView.animate(withDuration: duration) {
      self.tableView.contentInset.bottom = keyboardVisibleHeight
      self.tableView.scrollIndicatorInsets.bottom = keyboardVisibleHeight

      let isShowing = keyboardVisibleHeight > 0
      if isShowing {
        self.tableView.scrollToRow(
          at: IndexPath(row: 1, section: 0),
          at: .none,
          animated: false
        )
      }
    }
  }

  func cancelButtonItemDidTap() {
    self.dismiss(animated: true, completion: nil)
  }

  func doneButtonItemDidTap() {
    self.setControlsEnabled(false)
    self.progressView.isHidden = false

    PostService.create(
      image: self.image,
      message: self.text,
      progress: { progress in
        self.progressView.progress = Float(progress.completedUnitCount) / Float(progress.totalUnitCount)
      },
      completion: { response in
        switch response.result {
        case .success:
          self.dismiss(animated: true, completion: nil)

        case .failure:
          self.setControlsEnabled(true)
          self.progressView.isHidden = true
        }
      }
    )
  }

  func setControlsEnabled(_ isEnabled: Bool) {
    self.cancelButtonItem.isEnabled = isEnabled
    self.doneButtonItem.isEnabled = isEnabled
    self.view.isUserInteractionEnabled = isEnabled
  }
}

extension PostEditViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
        as! PostEditViewImageCell
      cell.configure(image: self.image)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
        as! PostEditViewTextCell
      cell.configure(text: self.text)
      cell.textDidChange = { text in
        self.text = text
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
      }
      return cell
    }
  }
}

extension PostEditViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return PostEditViewImageCell.height(width: tableView.width)
    } else {
      return PostEditViewTextCell.height(width: tableView.width, text: self.text)
    }
  }
}

















