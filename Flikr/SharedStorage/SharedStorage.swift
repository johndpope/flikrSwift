import Foundation
import CoreData

//https://github.com/beobyte/GuessWho

final public class SharedStorage {
    
    public static let shared = SharedStorage()
    
    public var errorHandler: (Error) -> Void = { _ in }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = SharedPersistentContainer(name: "SharedStorage", managedObjectModel: self.managedObjectModel)
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                print("CoreData error \(error), \(String(describing: error._userInfo))")
                self?.errorHandler(error)
            }
        })
        
        return container
    }()
    
    public lazy var moc: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle(for: type(of: self)).url(forResource: "SharedStorageModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    // MARK: - Public methods
    
    public func add(phoneNumber: Int64, label: String, isScam: Bool,_ contentFlags: Int16 = 0b00000001) {
        let fetchRequest = PhoneNumberEntity.fetchRequest() as NSFetchRequest<PhoneNumberEntity>
        fetchRequest.predicate = NSPredicate(format: "phoneNumber = %lld", phoneNumber)
        
        do {
            if let existingNumber = try moc.fetch(fetchRequest).first {
                existingNumber.label = label
                existingNumber.contentFlags = contentFlags
            }
            else {
                if let entity = NSEntityDescription.insertNewObject(forEntityName: "PhoneNumberEntity", into: moc) as? PhoneNumberEntity{
                    entity.phoneNumber = phoneNumber
                    entity.label = label
                    entity.isScam = isScam
                    entity.contentFlags = contentFlags
                }
            
            }
            
            try moc.save()
        }
        catch {
            print("🔥 Error while adding phone number: \(error)")
        }
    }
    
    public func remove(phoneNumber: Int64) {
        let fetchRequest = PhoneNumberEntity.fetchRequest() as NSFetchRequest<PhoneNumberEntity>
        fetchRequest.predicate = NSPredicate(format: "phoneNumber = %lld", phoneNumber)
        
        do {
            if let existingNumber = try moc.fetch(fetchRequest).first {
                if existingNumber.contentFlags & ContentFlags.internalContent.rawValue > 0 {
                    existingNumber.contentFlags = ContentFlags.internalContent.rawValue
                }
                else {
                    moc.delete(existingNumber)
                }
            }
            try moc.save()
        }
        catch {
            print("🔥 Error while removing phone number: \(error)")
        }
    }
    
    public func allScamPhoneNumbers() -> [PhoneNumber]? {
        let predicate = NSPredicate(format: "isScam = %@", NSNumber(booleanLiteral: true))
        return phoneNumbers(with: predicate)
    }
    
    public func allSuspiciousPhoneNumbers() -> [PhoneNumber]? {
        let predicate = NSPredicate(format: "isScam = %@", NSNumber(booleanLiteral: false))
        return phoneNumbers(with: predicate)
    }
    
    public func markUserGeneratedPhoneNumbers(asScam: Bool) {
        if let phoneNumbers = allUserGeneratedPhoneNumbers() {
            for phoneNumber in phoneNumbers {
                phoneNumber.isScam = asScam
            }
            
            do {
                try moc.save()
            }
            catch {
                print("🔥 Error while setting isScam flag for user phone numbers: \(error)")
            }
        }
    }
    
    // MARK: - Private methods
    
    private func allUserGeneratedPhoneNumbers() -> [PhoneNumberEntity]? {
        let predicate = NSPredicate(format: "(contentFlags & %i) > 0", ContentFlags.userGeneratedContent.rawValue)
        return phoneNumbers(with: predicate) as? [PhoneNumberEntity]
    }
    
    private func phoneNumbers(with predicate: NSPredicate) -> [PhoneNumber]? {
        let fetchRequest = PhoneNumberEntity.fetchRequest() as NSFetchRequest<PhoneNumberEntity>
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "phoneNumber", ascending: true)
        fetchRequest.sortDescriptors = [ sortDescriptor ]
        
        let results = try? moc.fetch(fetchRequest)
        return results
    }
}
