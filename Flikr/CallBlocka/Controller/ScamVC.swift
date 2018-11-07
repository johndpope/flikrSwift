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
       
        
        configureUI()
        configureConstraints()
        
        fetchScamNumbers()
        
        // Refresh button item
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadTableView))
        self.navigationItem.leftBarButtonItem  = refreshItem
        
        
        // Add scam caller
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBlockedContact))
        self.navigationItem.rightBarButtonItem = addItem
    }
    
    @objc func addBlockedContact(){
        let vc = AddBlockContactVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func reloadTableView() {
        myTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
    }

}
