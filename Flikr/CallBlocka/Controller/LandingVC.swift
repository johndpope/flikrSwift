import Foundation
import UIKit
import Material


class LandingVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var selectedIndex:Int = 0
    let footerHeight:CGFloat = 80

    lazy var myTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        return tb
    }()
   
    
    var featuredTableHeader = FeaturedTableViewHeader()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "🦒 Landing"
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .white
        view.addSubview(myTableView)
        myTableView.backgroundColor = UIColor.onyx
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myTableView.separatorStyle = .none
        myTableView.register(NetworkLandingCell.self, forCellReuseIdentifier: NetworkLandingCell.ID)
        myTableView.tableFooterView = UITableViewHeaderFooterView(frame:CGRect(x:0,y:0,width:1,height:footerHeight))
        myTableView.dataSource = self
        myTableView.delegate = self

        configureHeader()
        reloadTableView()
        configureConstraints()
        addListeners()
    }

    
    // Featured Header image
    func configureHeader(){

        let photo = MyPhoto(id: 1, title: "Phone Scammers", photoDescription: "", thumbURL: "https://www.accountingweb.com/sites/default/files/styles/banner/public/phone_scam_fatihhoca.jpg?itok=ZAjH8_iD")
        featuredTableHeader.configureHeader(photo: photo)
        myTableView.tableHeaderView = featuredTableHeader
    }
    
    
    func addListeners(){
        NotificationCenter.default.addObserver(self, selector: #selector(dataLoaded),  name: kFlikrLoaded, object: nil)

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
        // call this to allow emoji in this title - but not in navigation items
         MyTabBar.resyncTabBarTitles()
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
