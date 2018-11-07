
import Foundation
import UIKit
import Contacts
import CallKit


class ContactVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var selectedIndex:Int = 0
    let footerHeight:CGFloat = 80
    let cellLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var myTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        return tb
    }()
    
    var blockList:[String] = []
    var filterSearchController = UISearchController()
    var contactArray:[CNContact] = []
    var sortOrder = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .white
        view.addSubview(myTableView)

        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myTableView.separatorStyle = .none
        myTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.ID)
        myTableView.tableFooterView = UITableViewHeaderFooterView(frame:CGRect(x:0,y:0,width:1,height:footerHeight))
        myTableView.dataSource = self
        myTableView.delegate = self
        
        reloadTableView()
        configureConstraints()
        


        }
    

    
    @objc func addBlockedContact(){
        
       let vc = UIViewController()
        vc.title = "Add Custom Number to block"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @objc func dataLoaded(){
        myTableView.reloadData()
        
    }
    
    // Snapkit layouts
    func configureConstraints(){
        myTableView.snp.remakeConstraints { (make) -> Void in
            make.width.height.top.equalToSuperview()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // initially populate the data
        if (contactArray.count == 0){
            contactArray = DM.getContacts()
        }   
       
        // call this to allow emoji in this title - but not in navigation items
        let navItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBlockedContact))
        self.navigationItem.rightBarButtonItem = navItem
    }
    
    
    
    func reloadTableView() {
        myTableView.reloadData()
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}
