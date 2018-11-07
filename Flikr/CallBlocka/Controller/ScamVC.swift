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
        
        // refresh
        let navItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadTableView))
        self.navigationItem.rightBarButtonItem = navItem
    }

    @objc func reloadTableView() {
        myTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
    }

}
