import Foundation
import Material
import SharedStorage


class AddBlockContactVC: UIViewController ,UITextFieldDelegate{
    
    //MARK: -Properties
    let headerLabel = UILabel(frame: .zero)
    let subheaderLabel = UILabel(frame: .zero)
    let phoneTextField = UITextField()

    
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    
    @objc  func done(){
        addNumberAndRefreshContext()
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.done()
  
        return true
    }
}
