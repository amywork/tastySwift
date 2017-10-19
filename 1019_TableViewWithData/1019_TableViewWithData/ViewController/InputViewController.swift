import UIKit

class InputViewController: UIViewController {
   
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveBtnHandler(_ sender: Any) {
        let newName = textField.text ?? ""
        DataCenter.mainCenter.addName(newName)
        self.navigationController?.popViewController(animated: true)
    }
    
}
