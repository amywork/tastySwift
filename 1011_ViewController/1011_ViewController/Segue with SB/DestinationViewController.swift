import UIKit

class DestinationViewController: UIViewController {
    @IBOutlet weak var textFieldLabel: UILabel!
    var sendedMsg: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeBtn = UIButton(type: .system)
        closeBtn.frame = CGRect(x: view.bounds.size.width-46, y: 30, width: 30, height: 30)
        closeBtn.setTitle("🔙", for: .normal)
        closeBtn.backgroundColor = .white
        view.addSubview(closeBtn)
        closeBtn.addTarget(self, action: #selector(self.close(_:)), for: .touchUpInside)
        
        textFieldLabel.text = sendedMsg
    }
    
    func takeMessage(_ msg: String) {
        sendedMsg = msg
    }
    
    @objc func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

