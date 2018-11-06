import Foundation
import UIKit
import Material


class LandingVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var selectedIndex:Int = 0
    let footerHeight:CGFloat = 80
    let cellLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var myTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        return tb
    }()
    var headerCV:UICollectionView!
    
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

        addHeaderView()
        reloadTableView()
        configureConstraints()
        addListeners()
    }

    
    // Featured Header image
    func addHeaderView(){
        cellLayout.scrollDirection = .horizontal
        headerCV = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: featuredHeaderHeight), collectionViewLayout: cellLayout)
        headerCV.register(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedCollectionViewCell.ID)
        headerCV.isPagingEnabled = true
        headerCV.autoresizingMask = [.flexibleWidth]
        headerCV.showsVerticalScrollIndicator = false
        headerCV.showsHorizontalScrollIndicator = true
        headerCV.isScrollEnabled = true
        headerCV.bounces = true
        headerCV.delegate = self
        headerCV.dataSource = self
        headerCV.backgroundColor = UIColor.onyx
        myTableView.tableHeaderView = headerCV

        
    }
    
    
    func addListeners(){
        NotificationCenter.default.addObserver(self, selector: #selector(dataLoaded),  name: kFlikrLoaded, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(featuredDataLoaded),  name: kFeaturedLoaded, object: nil)
    }
    
    @objc func featuredDataLoaded(){
             headerCV.reloadData()
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
