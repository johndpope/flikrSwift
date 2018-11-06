import Foundation

import Material
class MyNavigationController: UINavigationController {
    
}

public enum tabBarTag: Int {
    case landing = 0
    case callme = 1
    case addNumber = 2
    case tutorial = 3

}



class MyTabBar: NSObject {

    static let shared = MyTabBar()
    weak var weakMainTBC: MainTabBarController?

 
    // Here we are wrapping viewcontrollers with a uinavigation controller.
    //
    class func buildNavigationControllers() -> [UIViewController] {

        // Landing Page / Navigation Controller
        let landingVC = LandingVC()
        let landingNC = buildNavigationController(vc:landingVC)
        DM.weakLandingNC = landingNC
        landingNC.tabBarItem = tabBarItem(title: "Splash", imageName: "PhotoIcon", selectedImageName: "PhotoIcon", tagIndex: tabBarTag.landing.rawValue)
        
   
        // 2nd Tab
        let blankVC = UIViewController()
        blankVC.title = "Call Me"
        let blankNC = buildNavigationController(vc:blankVC)
        blankNC.tabBarItem = tabBarItem(title: "Apple", imageName: "AppleIcon", selectedImageName: "AppleIcon", tagIndex: tabBarTag.callme.rawValue)

        
        
        // 3rd Tab
        let addVC = UIViewController()
        addVC.title = "Add"
        let addNC = buildNavigationController(vc:addVC)
        addNC.tabBarItem = tabBarItem(title: "Add", imageName: "AppleIcon", selectedImageName: "AppleIcon", tagIndex: tabBarTag.addNumber.rawValue)

   
        // 4th Tab
        let tutorialVC = TutorialViewController()
        let tutorialNC = buildNavigationController(vc:tutorialVC)
        tutorialNC.tabBarItem = tabBarItem(title: "Tutorial", imageName: "AppleIcon", selectedImageName: "AppleIcon", tagIndex: tabBarTag.tutorial.rawValue)

        return  [landingNC,blankNC,addNC,tutorialNC]
    }

    class func tabBarItem(title: String, imageName: String, selectedImageName: String, tagIndex: Int) -> UITabBarItem {
        let item = UITabBarItem(title: title,
                                image: UIImage(named: imageName),
                                selectedImage: UIImage(named: selectedImageName))
        item.titlePositionAdjustment = UIOffset(horizontal:0, vertical:-5)
        item.tag = tagIndex
        return item
    }

    class func buildNavigationController(vc: UIViewController) -> MyNavigationController {

        let nc = MyNavigationController()
        nc.navigationBar.isTranslucent = false
        nc.viewControllers = [vc]
        
        return nc
    }
  
    
    // why does this exist? the titles / navigation item titles differ - this fixes things
    class func resyncTabBarTitles() {
        if let vcs = MyTabBar.shared.weakMainTBC?.viewControllers {
            for (index, vc) in vcs.enumerated() {
                if index == tabBarTag.landing.rawValue {
                    vc.tabBarItem.title = "landing"
                }
                if index == tabBarTag.callme.rawValue {
                    vc.tabBarItem.title = "Call Me"
                }
                if index == tabBarTag.addNumber.rawValue {
                    vc.tabBarItem.title = "Add"
                }
                if index == tabBarTag.tutorial.rawValue {
                    vc.tabBarItem.title = "Tutorial"
                }
                
            }
        }
    }

    
  
}




