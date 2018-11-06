
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
        return true
    }

    
    // Create main window with uitabar controller via MyTabBar
    // encapsulate view controllers inside uinvagigation controllers
    func buildWindow() {
        window = UIWindow.window()
        DM.weakWindow = window
        
        let mainTBC = MainTabBarController()
        MyTabBar.shared.weakMainTBC = mainTBC
        mainTBC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainTBC.viewControllers = MyTabBar.buildNavigationControllers()
        mainTBC.delegate = MyTabBar.shared
        mainTBC.tabBar.isTranslucent = true
        window?.rootViewController = mainTBC
        window?.makeKeyAndVisible()
        
    }
    

   
    // Used to configure all uiview colors / fonts etc
    func configureAppearanceService() {
        print("Enabling AppearanceService proxy")
        AppearanceService.shared.setGlobalAppearance()
    }

}

