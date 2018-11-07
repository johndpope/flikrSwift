import Foundation
import Material

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.statusBarBackgroundColor = UIColor.black
    }
    
    
    //MARK: UI
    private func configureUI(){
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = UIColor.onyx
        
        view.addSubview(headerLabel)
        headerLabel.textColor = .white
        headerLabel.text = "Add number to block"
        headerLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        headerLabel.textAlignment = .center
        

        view.addSubview(phoneTextField)
        phoneTextField.text = ""
        phoneTextField.textColor = .white
        phoneTextField.placeholder = "Phone... 12341234"
        phoneTextField.keyboardType = .numberPad
        phoneTextField.returnKeyType = .done
        phoneTextField.clearButtonMode = .whileEditing
        phoneTextField.becomeFirstResponder()
        phoneTextField.textAlignment = .center
        phoneTextField.delegate = self
        
        
        let navItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem = navItem
    
    }
   @objc  func done(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureConstraints() {
        
        headerLabel.snp.remakeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
        

        phoneTextField.snp.remakeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.top.equalTo(headerLabel.snp.bottom)
            make.width.centerX.equalToSuperview()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.done()
        return true
    }
}