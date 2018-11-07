import Foundation
import CoreData

// Cherry Picked code from GuessWho
// https://github.com/beobyte/GuessWho


struct CoreDataServiceConsts {
    static let applicationGroupIdentifier = "group.com.johnpope.callBlocka.container"
}


public protocol PhoneNumber {
    var contentFlags: Int16 { get }
    var isScam: Bool { get set }
    var label: String? { get }
    var phoneNumber: Int64 { get }
}

public enum ContentFlags: Int16 {
    case internalContent = 0b00000001
    case userGeneratedContent = 0b00000010
}


public class PhoneNumberEntity: NSManagedObject {

    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneNumberEntity> {
        return NSFetchRequest<PhoneNumberEntity>(entityName: "PhoneNumberEntity");
    }
    
    @NSManaged public var contentFlags: Int16
    @NSManaged public var isScam: Bool
    @NSManaged public var label: String?
    @NSManaged public var phoneNumber: Int64
    
}

extension PhoneNumberEntity: PhoneNumber {}



final class SharedPersistentContainer: NSPersistentContainer {
    internal override class func defaultDirectoryURL() -> URL {
        var url = super.defaultDirectoryURL()
        if let newURL =
            FileManager.default.containerURL(
                forSecurityApplicationGroupIdentifier: CoreDataServiceConsts.applicationGroupIdentifier) {
            url = newURL
        }
        return url
    }
}
