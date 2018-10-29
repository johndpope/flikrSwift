
import Foundation
import UIKit

let kFlikrLoaded = NSNotification.Name("kFlikrLoaded")
let kFeaturedLoaded = NSNotification.Name("kFeaturedLoaded")

class Notificator {
    static func fireNotification(_ named: NSNotification.Name) {
        NotificationCenter.default.post(name: named, object: nil)
    }
}
