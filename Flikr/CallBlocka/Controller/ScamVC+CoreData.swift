import Foundation
import UIKit
import Material
import CoreData
import SharedStorage

// MARK: - NSFetchedResultsControllerDelegate

extension ScamVC: NSFetchedResultsControllerDelegate {
    
    func fetchScamNumbers(){
        let fetchRequest = PhoneNumberEntity.fetchRequest() as NSFetchRequest<PhoneNumberEntity>
        let sortDescriptor = NSSortDescriptor(key: "phoneNumber", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "(contentFlags & %i) > 0", ContentFlags.userGeneratedContent.rawValue)
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: SharedStorage.shared.moc,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        }
        catch {
            print("🔥Error while fetching data: \(error)")
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        myTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            myTableView.insertRows(at: [newIndexPath!], with: .automatic)
            
        case .delete:
            myTableView.deleteRows(at: [indexPath!], with: .automatic)
            
        case .update:
            let cell = myTableView.cellForRow(at: indexPath!) as! ScamPhoneNumberCell
            let phoneNumber = fetchedResultsController.object(at: indexPath!)
            let strNumber =  String(phoneNumber.phoneNumber)
            cell.configureCell(number:strNumber)

            
        case .move:
            myTableView.deleteRows(at: [indexPath!], with: .automatic)
            myTableView.insertRows(at: [newIndexPath!], with: .automatic)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        myTableView.endUpdates()
    }
}
