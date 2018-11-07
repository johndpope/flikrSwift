import Foundation
import Material
import SharedStorage
import CallKit

let callHandlerExtensionIdentifier =  "com.johndpope.callBlocka.callHandler"
extension AddBlockContactVC{
 
    func addNumberAndRefreshContext(){
        phoneTextField.resignFirstResponder()
        
        if (phoneTextField.text != ""){
            if let number = Int64(phoneTextField.text!){
                SharedStorage.shared.add(phoneNumber: number, label: "SCAM", isScam: true)
            }
        }
        
        CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier:callHandlerExtensionIdentifier, completionHandler:nil )
    }
    
}
