
import UIKit
import CallKit
import PushKit
import SharedStorage


extension AppDelegate {
   
    // Create main window with uitabar controller via MyTabBar
    // encapsulate view controllers inside uinvagigation controllers
    func buildWindow() {
        window = UIWindow.window()
        
        
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
    
    
    
    // Used to configure all uiview colors / fonts etc
    func configureAppearanceService() {
        print("Enabling AppearanceService proxy")
        AppearanceService.shared.setGlobalAppearance()
    }
}

