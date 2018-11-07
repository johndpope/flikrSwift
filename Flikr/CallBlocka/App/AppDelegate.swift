
import UIKit
import PushKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Callkit / pushkit - used to simulate the calling
    let callManager = SpeakerboxCallManager()
    var providerDelegate: ProviderDelegate?
    let pushRegistry = PKPushRegistry(queue: DispatchQueue.main)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {


        buildWindow()
        configureAppearanceService()
       
        APIManager.shared.fetchLandingContent()
     
        configureCallKit()
        addScamNumbers()
        
        return true
    }

    

}

