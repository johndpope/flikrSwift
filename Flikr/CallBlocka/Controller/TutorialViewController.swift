import Foundation
import UIKit
import SnapKit

class TutorialViewController:UIViewController{
    
    let customView = UIView(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "🕵️‍♂️ How to Enable callBlocka"
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .onyx
       view.addSubview(customView)
        
        
       configureConstraints()
       addInstructions()
        
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
        
        func addInstructions(){
            customView.addSubview(titleLabel)
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
            titleLabel.text = "1. Open Settings\n2. Select Phone.\n3. Select Call Blocking & Identification\n4.Turn ON switchers for callBlocka..."
            titleLabel.textColor = .white
            titleLabel.numberOfLines = 6
            titleLabel.textAlignment = .left
            titleLabel.snp.remakeConstraints { (make) -> Void in
                make.width.equalToSuperview().offset(-30) // make it less to avoid overlapping
                make.bottom.equalToSuperview().offset(-10)
                make.left.equalToSuperview().offset(10)
                make.top.equalToSuperview()
            }
        }
        

    // Snapkit layouts
    func configureConstraints(){
        customView.snp.remakeConstraints { (make) -> Void in
            make.width.height.top.equalToSuperview()
        }
        
    }
    
}
