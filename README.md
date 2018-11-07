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
I kept this in to demonstrate programatically layouts and how code reuse can accelerate building apps.



Any identified calls addAllIdentificationPhoneNumbers will be marked as a suspicious call.
Scam calls will be silently blocked. The 2nd tab will simulate this UI with audio sounds.

**Notes On Programmatic UI**       
https://github.com/SnapKit/SnapKit       
Coding constraints with snapkit can reduce errors(broken constraints) and rapidly pin point problem errors.        
It can be a steep hill for newbies - but I've found it dependable again again across devices.        
Snapkit does have close to 14,000 stars on github.       
If there was a more popular way to code constraints programmatically, I'd be open to suggestions.       
I've worked with some juniors and after a week or two - they catch up to speed and begin love this style of coding.        
It certainly speeds up development and you became a lot more productive.      
This biggest gotcha with this is simply you to add any view to the view first. 
The language is very presriptive and doesn't hide what's it's doing. 
eg. add label - make it as wide as a screen - make the height 80.
advance. inset it by 10 pixels. 

````swift

// 1. ADD TO SUBVIEW
        view.addSubview(headerLabel)
        
// 2. CONFIGURE CONSTRAINTS
        headerLabel.snp.remakeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.left.equalToSuperview().offset(10)
        }
````

