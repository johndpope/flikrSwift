import UIKit
import CoreData
import SharedStorage
import CallKit

class ScamVC: UIViewController {
    
    lazy var myTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        return tb
    }()

    
    var selectedPhoneNumber: PhoneNumber?
    var fetchedResultsController: NSFetchedResultsController<PhoneNumberEntity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Scam Numbers"
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .onyx
        view.addSubview(myTableView)
        
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myTableView.separatorStyle = .none
        myTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.ID)
        myTableView.tableFooterView = UITableViewHeaderFooterView(frame:CGRect(x:0,y:0,width:1,height:footerHeight))
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = .onyx
        

        fetchScamNumbers()
        
        // refresh
        let navItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadTableView))
        self.navigationItem.rightBarButtonItem = navItem
    }

    @objc func reloadTableView() {
        myTableView.reloadData()
    }


}
