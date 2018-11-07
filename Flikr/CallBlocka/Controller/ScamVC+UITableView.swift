import Foundation
import UIKit
import Material

// MARK: - UITableViewDataSource

extension ScamVC:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let contoller = fetchedResultsController {
            let n = contoller.sections?[section].numberOfObjects ?? 0
            return n
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ScamPhoneNumberCell.ID, for: indexPath) as? ScamPhoneNumberCell{

            let phoneNumber = fetchedResultsController.object(at: indexPath)
            let strNumber =  String(phoneNumber.phoneNumber)
            cell.configureCell(number:strNumber)
            return cell
        }
        return ScamPhoneNumberCell()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        selectedPhoneNumber = fetchedResultsController.object(at: indexPath)
        //performSegue(withIdentifier: UIStoryboardSegue.showPhoneNumberSegueId, sender: self)
    }
}
