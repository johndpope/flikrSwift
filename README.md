# Call kit scam call blocker      
https://www.raywenderlich.com/701-callkit-tutorial-for-ios            

      
**Challenges**      
It seems the apple demo code was deleted or taken offline from here
https://developer.apple.com/documentation/callkit      
      
At some point I wanted to demonstrate making calls - but can't find official apple sources.    
https://github.com/opentok/CallKit/blob/master/CallKitDemo/SpeakerboxCallManager.swift      
      
**CallDirectoryHandler.swift**
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
The generic CallDirectoryHandler has been updated to be more dynamic rather than using hard coded numbers.
I've add this by cherry picking some coredata code from GuessWho to incorporate - 
but feel this doesn't represent my own approach. I'd be more inclined to use realm.

I added this and wired it up to add numbers - but needs more thought.
https://github.com/beobyte/GuessWho/blob/master/SharedStorage/SharedStorage.swift      



**NSUserDefaults**
Using NSUserDefaults as shared storage - this approach was taken here -      
https://github.com/BCSingh/CallBlocker     
saving / storing to defaults can be slow - so with a large database of numbers this could      
have performance issues.      


This project was built on top of another assignment with flickr which incorporates some networking / ui code.
I kept this in to show off my own code rather than I well I can copy and paste code.



