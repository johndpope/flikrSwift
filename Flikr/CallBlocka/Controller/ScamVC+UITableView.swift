import Foundation
import UIKit
import Material

// MARK: - UITableViewDataSource

extension ScamVC:UITableViewDataSource,UITableViewDelegate {
  
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let contoller = fetchedResultsController {
                let n = contoller.sections?[section].numberOfObjects ?? 0
                return n
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ScamPhoneNumberCell.ID, for: indexPath) as! ScamPhoneNumberCell
            
//            configureCell(cell, at: indexPath)
            
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedPhoneNumber = fetchedResultsController.object(at: indexPath)
        //performSegue(withIdentifier: UIStoryboardSegue.showPhoneNumberSegueId, sender: self)
    }

