import UIKit
import Contacts


extension DataManager{

    
    func getContacts() -> [CNContact] {
        
        let status = CNContactStore.authorizationStatus(for: CNEntityType.contacts) as CNAuthorizationStatus
        if status == CNAuthorizationStatus.denied || status == CNAuthorizationStatus.restricted {
            self.promptUserForContactAccess()
            return []
        }
        
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactImageDataKey,
            
            CNContactThumbnailImageDataKey] as [Any]
        
        // Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        return results
    }
    
    public func loadContacts() {
        
        let status = CNContactStore.authorizationStatus(for: CNEntityType.contacts) as CNAuthorizationStatus
        if status == CNAuthorizationStatus.denied || status == CNAuthorizationStatus.restricted {
            self.promptUserForContactAccess()
            return
        }
        
        let contactStore = CNContactStore()
        DataManager.shared.contactStore = contactStore
        contactStore.requestAccess(for: .contacts, completionHandler: { (granted, error) -> Void in
            if granted == false {
                // request again
                self.promptUserForContactAccess()
            }
            else {
                let predicate = CNContact.predicateForContactsInContainer(withIdentifier: contactStore.defaultContainerIdentifier())
                var contacts: [CNContact] = []
                do {
                    contacts = try contactStore.unifiedContacts(matching: predicate, keysToFetch: [CNContactPhoneNumbersKey as CNKeyDescriptor])
                    
                    if contacts.count == 0 {
                        return
                    }
                    
                    let filteredContacts = NSMutableArray()
                    
                    for contactTemp in contacts {
                        let contactNew = contactTemp
                        let tempArray  = NSMutableArray()
                        if (contactNew.phoneNumbers).count > 0 {
                            
                            let phoneNumbers  = contactNew.phoneNumbers
                            for cnLblValue in phoneNumbers {
                                var cnPhNum : CNPhoneNumber = CNPhoneNumber()
                                cnPhNum = (cnLblValue as AnyObject).value(forKey: "value") as! CNPhoneNumber
                                var tempStr  = NSString()
                                tempStr = cnPhNum.value(forKey: "digits") as! NSString
                                tempStr = self.removeFormat(fromMobileNumber: tempStr as String) as NSString
                                tempArray.add(tempStr);
                            }
                            
                            for i in 0  ..< tempArray.count
                            {
                                let phoneNumber : String = (tempArray.object(at: i)) as! String
                                if phoneNumber.count > 0 {
                                   let resultString : String = (phoneNumber.components(separatedBy: NSCharacterSet.whitespaces) as NSArray).componentsJoined(by: "")
                                    filteredContacts.add(resultString)
                                }
                            }
                        }
                        
                    }
                    
                    filteredContacts.sort(using: [NSSortDescriptor.init(key: "self", ascending: true)])
//                    defaults?.set(filteredContacts, forKey: "blockList")
//                    defaults?.synchronize()
//                    self.filteredContacts = filteredContacts
                    
                }catch {
                    
                }
            }
        })
        
    }
    
    func filterContactsRemoveBlockedOnes(){
        
    }
    func removeFormat(fromMobileNumber num: String) -> String {
        var mobileNumber: String = num
        mobileNumber = mobileNumber.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        mobileNumber = mobileNumber.trimmingCharacters(in: CharacterSet.symbols)
        mobileNumber = mobileNumber.trimmingCharacters(in: CharacterSet.punctuationCharacters)
        mobileNumber = mobileNumber.trimmingCharacters(in: CharacterSet.controlCharacters)
        mobileNumber = mobileNumber.replacingOccurrences(of: "+", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: " ", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: "\u{00a0}", with: "")
        return mobileNumber
    }
    
    
     func promptUserForContactAccess() {
        
       self.appDelegate?.promptUserForContactAccess()
    }

}

