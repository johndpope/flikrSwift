import UIKit
import Alamofire
import Contacts




let DM = DataManager.shared


let kPlaceholderImage = UIImage(named: "placeholder")

let featuredHeaderHeight:CGFloat = 300



var screenWidth = UIScreen.main.bounds.width
var screenHeight = UIScreen.main.bounds.height

//All views which constraints are based on device's width/height needs to refer to this
struct currentSize {
    static var height : CGFloat = screenHeight
    static var width : CGFloat = screenWidth
    
    static func updateCurrentSize(size: CGSize) {
        currentSize.height = size.height
        currentSize.width = size.width
        
    }
    
    static func getCurrentSize() -> CGSize {
        return CGSize(width: currentSize.width, height: currentSize.height)
    }
    

}


class DataManager {

    static let shared = DataManager()
    weak var weakWindow: UIWindow?
    weak var appDelegate:AppDelegate?
    weak var weakLandingNC:MyNavigationController?
    weak var contactStore:CNContactStore?

    var networkChannels: [Channel] = []
    var flikrChannels: [FlikrChannel] = []
    var featuredPhotos: [Photo] = []
    var contacts: [CNContact] = []

}

public struct Contact:Decodable{
    
    var id: Int
    var title: String
    var firstName:String
    var photoDescription: String
    var thumbURL: String
    
}
