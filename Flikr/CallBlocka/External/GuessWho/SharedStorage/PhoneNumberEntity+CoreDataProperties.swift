import Foundation
import CoreData


extension PhoneNumberEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneNumberEntity> {
        return NSFetchRequest<PhoneNumberEntity>(entityName: "PhoneNumberEntity");
    }

    @NSManaged public var contentFlags: Int16
    @NSManaged public var isScam: Bool
    @NSManaged public var label: String?
    @NSManaged public var phoneNumber: Int64

}

extension PhoneNumberEntity: PhoneNumber {}
