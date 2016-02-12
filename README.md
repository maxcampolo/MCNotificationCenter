# MCNotificationCenter
`MCNotificationCenter` is a replacement for calls to NSNotificationCenter that makes dealing with notifications easier. The singleton class manages and tracks registered observers so you don't have to! Use `MCNotificationCenter` to prevent observer-related crashes when registering observers and sending notifications.

## Features
* Add and remove observers without worrying about app crashes
* Check if a class is registered as an observer before removing or adding it, or don't becuase it will handle that automatically ;)
* Can act as a single observer for all KVO needs
* Convenience methods for adding KVO to objects with blocks
* Post a notification only if there is an observer registered, or only if there is a specific class registered as an observer

# Installation
Using CocoaPods:

```sh
$ pod 'MCNotificationCenter'
```

Or copy `MCNotificationCenter.swift` and `NSObject+EasyKVO.swift` into a project. Add to a bridging header if necessary. 

## Usage

Check out the example project in the repo for full code samples.

All calls should use the `MCNotificationCenter.defaultCenter` singleton
```objective-c
MCNotificationCenter.defaultCenter
```

##### NSNotificationCenter

Add an observer using one of the provided methods. It follows a similar structure to NSNotificationCenter.
```objective-c
MCNotificationCenter.defaultCenter.addObserver(self, selector: Selector("printNotification:"), name: "myNotification", object: nil)}
```

Remove an observer. Checking if the observer exists is optional, it's safe to call remove even if the observer doesn't exist.
```objective-c
if MCNotificationCenter.defaultCenter.isObserverForName("myNotification", observer: self) {
    MCNotificationCenter.defaultCenter.removeObserverWithName("myNotification", observer: self)
}
```

Note: You can remove all registered observers for a class or object.

##### KVO

Add a key value observer with a closure (setting MCNotificationCenter.defaultCenter is required for this functionality. To implement a different observer class, set the class as the observer and nil for the block)

```objective-c
MCNotificationCenter.defaultCenter.addKeyValueObserver(MCNotificationCenter.defaultCenter, onObject: self.myObject, forKeyPath: "someValue", options: .New, context: nil) { () -> () in
        println(self.myObject.someValue)
}
```

Or use the `NSObject+EasyKVO` extension which provides convenience methods for using MCNotificationCenter functions
```objective-c
myObject.addObserver("someValue", usingBlock: { () -> () in
     println(self.myObject.value)
})
```

And remove easily using just the keypath
```objective-c
myObject.removeObserver("someValue")
```

## Class Methods

Check out the files and code comments. 

## License
* MIT 

## Enjoy
Questions, comments or ideas? Feel free to send me a message or post an issue. 

For fixes, additions, improvements or any other cool stuff pull requests welcome.
