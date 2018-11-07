import Foundation
import UIKit


extension ContactVC {
    
    // MARK: UITableview datasource / Delegate
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    // MARK: - Table view delegates & datasources
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        let number = self.contactArray.count
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.ID, for: indexPath) as? ContactTableViewCell{
            let contact = self.contactArray[indexPath.row]
            cell.configureCell(item:contact)
          return cell
        }

        return UITableViewCell()
    }
    
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {

        }
    }

    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        let contact = contactArray[indexPath.row]
        
        let detailVC = ContactDetailVC()
        detailVC.selectedContact = contact
        detailVC.title = contact.familyName
        self.navigationController?.pushViewController(detailVC, animated: true)
        
        
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    

    
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                            titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "Block Number"
    }

}
