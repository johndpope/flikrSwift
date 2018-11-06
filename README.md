# Call kit scam call blocker

https://www.raywenderlich.com/701-callkit-tutorial-for-ios      


**Challenges**
It seems the demo was deleted or taken offline from here
https://developer.apple.com/documentation/callkit


It seems like there used to be some CallKit code to demonstrate making calls - but can't find official sources.
https://github.com/opentok/CallKit/blob/master/CallKitDemo/SpeakerboxCallManager.swift


I've enabled the CallDirectoryHandler.swift extension to block scam calls and alert suspicious calls.

I wanted to fake a call using following code to simulate incoming calls / this required some additional files to be added into 
External/Apple folder     

````swift
        let handle = CXHandle(type: .phoneNumber, value: handle)
        let startCallAction = CXStartCallAction(call: UUID(), handle: handle)

        startCallAction.isVideo = video

        let transaction = CXTransaction()
        transaction.addAction(startCallAction)
````



