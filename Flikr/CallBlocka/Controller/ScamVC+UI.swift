import UIKit
import CoreData
import SharedStorage
import CallKit

extension ScamVC {
    
    
    func configureUI(){
        view.addSubview(myTableView)
        
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myTableView.separatorStyle = .none
        myTableView.register(ScamPhoneNumberCell.self, forCellReuseIdentifier: ScamPhoneNumberCell.ID)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = .onyx
    }
    
    //MARK: - Snapkit Constraints
    func configureConstraints() {
        myTableView.snp.remakeConstraints { (make) -> Void in
            make.width.height.top.equalToSuperview()
        }
    }
}
