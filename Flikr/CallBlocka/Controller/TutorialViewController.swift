import Foundation
import UIKit
import SnapKit

class TutorialViewController:UIViewController{
    
    let customView = UIView(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    let headerLabel = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .onyx
        
        
        configureUI()
        configureConstraints()
        
        
        // Top done button
        let btnDone = UIBarButtonItem(title: "done", style: .plain, target: self, action:  #selector(dismissWindow))
        self.navigationItem.rightBarButtonItem = btnDone
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MyTabBar.resyncTabBarTitles() // fixes a bug where tab bar title is eroneously updated
    }
    
    @objc func dismissWindow(){
        UserDefaults.standard.set(true, forKey: UserDefaults.tutorialPassedKey)
        self.parent?.dismiss(animated: true, completion: nil)
    }
    
    // Add Labels to view
    func configureUI(){
        
        view.addSubview(headerLabel)
        headerLabel.textColor = .white
        headerLabel.text = "🕵️‍♂️ How to Enable callBlocka"
        headerLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        headerLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        titleLabel.text = "1. Open Settings\n2. Select Phone.\n3. Select Call Blocking & Identification\n4. Turn ON switchers for callBlocka..."
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 6
        titleLabel.textAlignment = .left

    }
    
    
    // Snapkit layouts
    func configureConstraints(){
        
        headerLabel.snp.remakeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
        
        
        titleLabel.snp.remakeConstraints { (make) -> Void in
            make.height.equalTo(200)
            make.top.equalTo(headerLabel.snp.bottom)
            make.width.equalToSuperview()
        }
        
    }
    
    
}
