import CoreData

struct CoreDataServiceConsts {
    static let applicationGroupIdentifier = "group.com.johnpope.callBlocka.container"
}

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
