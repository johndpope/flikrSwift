
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {


        buildWindow()
        configureAppearanceService()
       
        APIManager.shared.fetchLandingContent()
     
        return true
    }

    
    // Create main window with uitabar controller via MyTabBar
    // encapsulate view controllers inside uinvagigation controllers
    func buildWindow() {
        window = UIWindow.window()
        DM.weakWindow = window
        
        let mainTBC = UITabBarController()
        MyTabBar.shared.weakMainTBC = mainTBC
        mainTBC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainTBC.viewControllers = MyTabBar.buildNavigationControllers()
        mainTBC.delegate = MyTabBar.shared
        mainTBC.tabBar.isTranslucent = true
        window?.rootViewController = mainTBC
        window?.makeKeyAndVisible()
        
        // TODO request permission to contacts?
        
        requestPermission()
    }
    
    func requestPermission(){
        let cm = CallManager()
        DataManager.shared.callManager = cm
        DM.callManager?.startCall(handle: "1111", videoEnabled: false)
    }
   
    // Used to configure all uiview colors / fonts etc
    func configureAppearanceService() {
        print("Enabling AppearanceService proxy")
        AppearanceService.shared.setGlobalAppearance()
    }

    func displayIncomingCall(uuid: UUID, handle: String, hasVideo: Bool = false, completion: ((NSError?) -> Void)?) {
   //     providerDelegate.reportIncomingCall(uuid: uuid, handle: handle, hasVideo: hasVideo, completion: completion)
    }
}

