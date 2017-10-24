
import UIKit

protocol ViewController2Delegate {
  
  func didSendText(string: String)
}


class ViewController2: UIViewController {
  var delegate: ViewController2Delegate?
  var formerViewController: ViewController?
  
  @IBOutlet weak var textField: UITextField!
  
  var didTapButtonClosure: ((String) -> Void )?
  
  
  @IBAction func didTapButton(_ sender: UIButton) {
    
    didTapButtonClosure?(textField.text!)
    delegate?.didSendText(string: textField.text!)
    
    NotificationCenter.default.post(name: NSNotification.Name.init("send"), object: textField.text!)
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
}
