
import UIKit
import PushKit
import AWSCognitoIdentityProvider

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Callkit / pushkit - used to simulate the calling
    let callManager = SpeakerboxCallManager()
    var providerDelegate: ProviderDelegate?
    let pushRegistry = PKPushRegistry(queue: DispatchQueue.main)
    
    // Merge AWS

    var signInViewController: SignInViewController?
    var mfaViewController: MFAViewController?
    var navigationController: UINavigationController?
    var storyboard: UIStoryboard?
    var rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {


        configureAWS()
        buildWindow()
        addDebugConsole()
        configureAppearanceService()
       
        APIManager.shared.fetchLandingContent()
     
        configureCallKit()
        
        if !UserDefaults.standard.bool(forKey: UserDefaults.addNumbersOnLaunchKey) {
            addScamNumbers()
            addSuspiciousCallNumbers()
        }
        DM.appDelegate = self
        
        return true
    }

    

}

