import Foundation
import UIKit



class MainTabBarController: UITabBarController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults.standard.bool(forKey: UserDefaults.tutorialPassedKey) {
            let tutorialVC  = TutorialViewController()
            let tutorialNC = UINavigationController(rootViewController: tutorialVC)
            self.present(tutorialNC, animated: true) {
                
            }
        }
    }
    

}


extension MyTabBar: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect vc: UIViewController) {
        print("OK")
        MyTabBar.resyncTabBarTitles()
        if  tabBarController.selectedIndex == 1{
            DM.appDelegate?.testIncomingCall()
        }

    }
}
