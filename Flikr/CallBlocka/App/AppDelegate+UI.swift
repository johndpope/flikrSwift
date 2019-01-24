
import UIKit
import CallKit
import PushKit
import SharedStorage
import LumberjackConsole
import CocoaLumberjack

public var defaultDebugLevel = DDLogLevel.verbose

extension AppDelegate {
   
    // Create main window with uitabar controller via MyTabBar
    // encapsulate view controllers inside uinvagigation controllers
    func buildWindow() {
        
        window = UIWindow.window()
        let     navigationController = UIStoryboard.mainStoryboard().instantiateInitialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    
    }
    
    func enterCallBlockaMode(){

         
         let mainTBC = MainTabBarController()
         mainTBC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         mainTBC.viewControllers = MyTabBar.buildNavigationControllers()
         mainTBC.delegate = MyTabBar.shared
         mainTBC.tabBar.isTranslucent = true
         window?.rootViewController = mainTBC
         window?.makeKeyAndVisible()
         
         // weak global variables to navigate around programatically
         DM.weakWindow = window
         MyTabBar.shared.weakMainTBC = mainTBC
         DM.appDelegate = self
    }
    func addDebugConsole(){
        print("⛳️ INFO: add debug console")
        DDLog.add(DDTTYLogger.sharedInstance, with: defaultDebugLevel) // TTY = Xcode console
        DDLog.add(DDASLLogger.sharedInstance, with: defaultDebugLevel) // ASL = Apple System Logs
        defaultDebugLevel = DDLogLevel.verbose
        PTEDashboard.shared().show()
    }
    
    
    // Used to configure all uiview colors / fonts etc
    func configureAppearanceService() {
        print("⛳️ INFO: Enabling AppearanceService proxy")
        AppearanceService.shared.setGlobalAppearance()
    }
}

