import Foundation
import UIKit


extension ContactDetailVC {
    
    // MARK: UITableview datasource / Delegate
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "OK")
 
 
        if (indexPath.row ==  0 ){
            cell.textLabel!.text = self.selectedContact?.givenName
       
        }
        if (indexPath.row == 1){
            cell.textLabel!.text = self.selectedContact?.familyName
        }
        
        
        return cell
    }
    
    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        print("didSelectRowAt")
        
        
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    

    
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerSection = HeaderSection(sectionName: "", sectionTitleHeight: 60)
        return headerSection
    }
}
