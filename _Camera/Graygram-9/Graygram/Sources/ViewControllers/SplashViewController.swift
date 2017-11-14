import UIKit

final class SplashViewController: UIViewController {
  fileprivate let activityIndicatorView =
    UIActivityIndicatorView(activityIndicatorStyle: .gray)

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(activityIndicatorView)
    activityIndicatorView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    activityIndicatorView.startAnimating()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    UserService.me { response in
      switch response.result {
      case .success(let value):
        print("내 프로필 정보 받아오기 성공 \(value)")
        AppDelegate.instance?.presentMainScreen()

      case .failure(let error):
        print("내 프로필 정보 받아오기 실패 \(error)")
        AppDelegate.instance?.presentLoginScreen()
      }
    }
  }
}













