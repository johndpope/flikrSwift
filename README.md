# Call kit scam call blocker      
https://www.raywenderlich.com/701-callkit-tutorial-for-ios            

      
**Challenges**      
It seems the apple demo code was deleted or taken offline from here
https://developer.apple.com/documentation/callkit      
      
It seems like there used to be some CallKit code to demonstrate making calls - but can't find official apple sources.      
https://github.com/opentok/CallKit/blob/master/CallKitDemo/SpeakerboxCallManager.swift      
      
      
I've added the CallDirectoryHandler.swift extension to block scam calls and alert suspicious calls.      
      
I wanted to fake a call using following code to simulate incoming calls / this required the additional Apple files to be added into       
External/Apple folder that I've marked as they have been copied and pasted. 
This the Call Me button. 
      
````swift
        let handle = CXHandle(type: .phoneNumber, value: handle)
        let startCallAction = CXStartCallAction(call: UUID(), handle: handle)

        startCallAction.isVideo = video

        let transaction = CXTransaction()
        transaction.addAction(startCallAction)
````

   
      
      
**Limitations with code**      
The generic CallDirectoryHandler is hard coded to specific numbers.      
This will quickly run into problems when we want to add numbers more dynamically.      
We want our ios app to talk to the extension to refresh / add numbers.      
There's no shared storage / db layer in this app.      
This project achieved this integration - and while I could cherry pick code to incorporate - this is beyond scope of project.   
I added this and wired it up to add numbers - but 
https://github.com/beobyte/GuessWho/blob/master/SharedStorage/SharedStorage.swift      



// When need be - the app if it was to download a database of numbers - we can call this method to begin the refresh of the call handler extension
CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: "com.johndpope.callBlocka.callHandler", completionHandler: nil)


**NSUserDefaults**
Using NSUserDefaults as shared storage - this approach was taken here -      
https://github.com/BCSingh/CallBlocker     
saving / storing to defaults can be slow - so with a large database of numbers this could      
have performance issues.      

