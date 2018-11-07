
import Foundation
import UIKit
import Contacts

class ContactDetailVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var selectedIndex:Int = 0
    let cellLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var myTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        return tb
    }()

    
    var selectedContact:CNContact?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .onyx
        view.addSubview(myTableView)

        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myTableView.tableFooterView = UITableViewHeaderFooterView(frame:CGRect(x:0,y:0,width:1,height:footerHeight))
        myTableView.dataSource = self
        myTableView.delegate = self
        
        self.title = "Under construction"

        }
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
    
    }

    @objc func dataLoaded(){
        myTableView.reloadData()
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}
