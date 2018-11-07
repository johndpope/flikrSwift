
import UIKit
import CallKit
import PushKit
import SharedStorage


extension AppDelegate :PKPushRegistryDelegate{
    func configureCallKit(){
        pushRegistry.delegate = self
        pushRegistry.desiredPushTypes = [.voIP]
        providerDelegate = ProviderDelegate(callManager: callManager)
        
    }
    
    func addScamNumbers(){
        print("⛳️ INFO: add default scam numbers")
        let allPhoneNumbers = [ 123,253_950_1212 ]
        for number in allPhoneNumbers{
            SharedStorage.shared.add(phoneNumber: Int64(number), label: "SCAM", isScam: true)
        }
    }
    
    
    func testIncomingCall(){
        let handle = "123" // why doesn't this block???
        let video = false
        
        self.displayIncomingCall(uuid: UUID(), handle:handle , hasVideo:video )
        
    }
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        guard let handle = userActivity.startCallHandle else {
            print("Could not determine start call handle from user activity: \(userActivity)")
            return false
        }
        
        guard let video = userActivity.video else {
            print("Could not determine video from user activity: \(userActivity)")
            return false
        }
        
        callManager.startCall(handle: handle, video: video)
        return true
    }

    
    // MARK: PKPushRegistryDelegate
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, for type: PKPushType) {
        /*
         Store push credentials on server for the active user.
         For sample app purposes, do nothing since everything is being done locally.
         */
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        guard type == .voIP else { return }
        
        if let uuidString = payload.dictionaryPayload["UUID"] as? String,
            let handle = payload.dictionaryPayload["handle"] as? String,
            let hasVideo = payload.dictionaryPayload["hasVideo"] as? Bool,
            let uuid = UUID(uuidString: uuidString)
        {
            displayIncomingCall(uuid: uuid, handle: handle, hasVideo: hasVideo)
        }
    }
    
    /// Display the incoming call to the user
    func displayIncomingCall(uuid: UUID, handle: String, hasVideo: Bool = false, completion: ((NSError?) -> Void)? = nil) {
        providerDelegate?.reportIncomingCall(uuid: uuid, handle: handle, hasVideo: hasVideo, completion:  { error in
            print("error:",error ?? "")
        })
    }
    
    
    public func promptUserForContactAccess() {
        
        let alert = UIAlertController(title: "Access to contacts.",
                                      message: "This app requires access to your contacts",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let settingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (UIAlertAction) in
            UIApplication.shared.open(NSURL.init(string: UIApplicationOpenSettingsURLString)! as URL, options: [:], completionHandler: nil)
        }
        alert.addAction(settingsAction)
        
        self.window?.rootViewController?.present(alert, animated: true) {
            
        }
    }
}

