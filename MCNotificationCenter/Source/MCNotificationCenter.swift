//
//  MCNotificationCenter.swift
//  MCNotificationCenter
//
//  Created by Max Campolo on 5/11/15.
//  Copyright (c) 2015 Max Campolo. All rights reserved.
//

/*
 *  This class is designed to replace all calls to NSNotificationCenter for registering and removing observers. 
 *  Instead of keeping track yourself, MCNotificationCenter will keep track of all registered observers for you.
 *  MCNotificationCenter can then check to see if a class is registered as an observer before removing or adding it.
 *
 *  MCNoficiationCenter also provides a unified observer class for key-value observation.
 *  Register key-value observers using convenient closure syntax and the blocks will be executed automatically.
 *
 */

import UIKit

// Singleton Instance
private let oneInstance = MCNotificationCenter()

class MCNotificationCenter: NSObject {
   
    // Arrays for holding observer structs
    var observers = [MCObserver]()
    var keyValueObservers = [MCKeyValueObserver]()
    
    // MARK: Default Center Singleton Instance
    
    class var defaultCenter: MCNotificationCenter {
        return oneInstance
    }
    
    // MARK: - Notification & Observer
    
    // MARK: Add Observer
    
    // Add a standard observer
    func addObserver(observer: AnyObject, selector: Selector, name: String?, object: AnyObject?) {
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: name, object: object);
        self.observers.append(MCObserver(observer: observer, selector: selector, name: name, object: object, block: nil, queue: nil))
    }
    
    // Add an observer with a block and queue
    func addObserver(observer: AnyObject, name: String?, object: AnyObject?, queue: NSOperationQueue?, usingBlock block: (NSNotification!) -> Void) {
        NSNotificationCenter.defaultCenter().addObserverForName(name, object: object, queue: queue, usingBlock: block)
        self.observers.append(MCObserver(observer: observer, selector: nil, name: name, object: object, block: block, queue: queue))
    }
    
    // MARK: Remove NSNotificationCenter observers
    
    // Remove all observers
    func removeAllObservers() {
        for var i = 0; i < self.observers.count; i++ {
            self.removeObserver(self.observers[i])
            self.observers.removeAtIndex(i)
        }
    }
    
    // Remove all observers for a specific observer
    func removeAllObserversForObserver(observer: AnyObject) {
        for var i = 0; i < self.observers.count; i++ {
            if let obs: AnyObject = self.observers[i].observer {
                if obs.isEqual(observer) {
                    self.removeObserver(self.observers[i])
                    self.observers.removeAtIndex(i)
                }
            }
        }
    }
    
    // Remove all observers with name
    func removeObserversWithName(name: String) {
        for var i = 0; i < self.observers.count; i++ {
            if let obsName: String = self.observers[i].name {
                if obsName == name {
                    self.removeObserver(self.observers[i])
                    self.observers.removeAtIndex(i)
                }
            }
        }
    }
    
    // Remove observer with name for observing class
    func removeObserverWithName(name: String, observer: AnyObject) {
        for var i = 0; i < self.observers.count; i++ {
            if let obs: AnyObject = self.observers[i].observer {
                if obs.isEqual(observer) && self.observers[i].name == name {
                    self.removeObserver(self.observers[i])
                    self.observers.removeAtIndex(i)
                }
            }
        }
    }
    
    // Remove all observers for object
    func removeObserversForObject(object: AnyObject) {
        for var i = 0; i < self.observers.count; i++ {
            if let obsObj: AnyObject = self.observers[i].object {
                if obsObj .isEqual(object) {
                    self.removeObserver(self.observers[i])
                    self.observers.removeAtIndex(i)
                }
            }
        }
    }
    
    // Remove observer with name for object
    func removeObserverWithName(name: String, object: AnyObject) {
        for var i = 0; i < self.observers.count; i++ {
            if let obj: AnyObject = self.observers[i].object {
                if obj.isEqual(object) && self.observers[i].name == name {
                    self.removeObserver(self.observers[i])
                    self.observers.removeAtIndex(i)
                }
            }
        }
    }
    
    // This is private becuase we only ever need two of these arguments to be able to remove an observer
    // Otherwise we will prevent an error by never reaching this step if we are not registered for a notification
    private func removeObserver(observer: MCObserver) {
        self.removeObserver(observer.observer!, name: observer.name!, object: observer.object)
    }
    
    private func removeObserver(observer: AnyObject, name: String, object: AnyObject?) {
        NSNotificationCenter.defaultCenter().removeObserver(observer, name: name, object: object)
    }
    
    // MARK: Get & Check Current Observers
    
    // Return observers for observer
    func observersForObserver(observer: AnyObject) -> [MCObserver] {
        var obsArray = [MCObserver]()
        for var i = 0; i < self.observers.count; i++ {
            if let obs: AnyObject = self.observers[i].observer {
                if obs.isEqual(observer) {
                    obsArray.append(self.observers[i])
                }
            }
        }
        return obsArray
    }
    
    // Return observers with name
    func observersWithName(name: String) -> [MCObserver] {
        var obsArray = [MCObserver]()
        for var i = 0; i < self.observers.count; i++ {
            if let obsName: String = self.observers[i].name {
                if obsName == name {
                    obsArray.append(self.observers[i])
                }
            }
        }
        return obsArray
    }
    
    // Return observers for object
    func observersForObject(object: AnyObject) -> [MCObserver] {
        var obsArray = [MCObserver]()
        for var i = 0; i < self.observers.count; i++ {
            if let obj: AnyObject = self.observers[i].object {
                if obj.isEqual(object) {
                    obsArray.append(self.observers[i])
                }
            }
        }
        return obsArray
    }
    
    // Check if an observer is registered for an object
    func isObserverForObject(object: AnyObject, observer: AnyObject) -> Bool {
        for var i = 0; i < self.observers.count; i++ {
            if let obj: AnyObject = self.observers[i].object {
                if let obs: AnyObject = self.observers[i].observer {
                    if obj.isEqual(object) && obs.isEqual(observer) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    // Check to see if an observer is registered for name
    func isObserverForName(name: String, observer: AnyObject) -> Bool {
        for var i = 0; i < self.observers.count; i++ {
            if let obs: AnyObject = self.observers[i].observer {
                if let obsName: String = self.observers[i].name {
                    if obs.isEqual(observer) && obsName == name {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    
    // MARK: - Key Value Observing
    
    // Add an observer with closure syntax - observer should always be MCNotificationCenter.defaultCenter
    func addKeyValueObserver(observer: NSObject, onObject object: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions, context: UnsafeMutablePointer<Void>, usingBlock block:() -> ()) {
        object.addObserver(observer, forKeyPath: keyPath, options: options, context: context);
        self.keyValueObservers.append(MCKeyValueObserver(observer: observer, object: object, keyPath: keyPath, options: options, context: context, block: block))
    }
    
    
    // Override for handling key-value change notifications
    // If MCNotificationCenter.defaultCenter is not the observer, this needs to be implemented in observer class
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        for obs in self.keyValueObservers {
            // Find the correct observer and execute the block
            if (obs.object!.isEqual(object) && obs.keyPath == keyPath && obs.context == context) {
                if let obsBlock = obs.block {
                    obsBlock()
                }
            }
        }
    }
    
    // MARK: Remove KVO
    
    // Clear all key value observers
    func removeAllKeyValueObservers() {
        //self.keyValueObservers.removeAll(keepCapacity: false)
        for var i = 0; i < self.keyValueObservers.count; i++ {
            if let obj = self.keyValueObservers[i].object {
                self.removeKeyValueObserver(self.keyValueObservers[i], object: obj)
            }
            self.keyValueObservers.removeAtIndex(i)
        }
    }
    
    // Remove all key value observers on an object
    func removeKeyValueObserversForObject(object: AnyObject) {
        for var i = 0; i < self.keyValueObservers.count; i++ {
            if let obsObj: AnyObject = self.keyValueObservers[i].object {
                if obsObj.isEqual(object) {
                    self.removeKeyValueObserver(self.keyValueObservers[i], object: object)
                    self.keyValueObservers.removeAtIndex(i)
                }
            }
        }
    }
    
    // Remove key observer on an object for a keypath
    func removeKeyValueObserver(object: AnyObject, keyPath: String) {
        for var i = 0; i < self.keyValueObservers.count; i++ {
            if let obsObj: AnyObject = self.keyValueObservers[i].object {
                if obsObj.isEqual(object) && self.keyValueObservers[i].keyPath == keyPath {
                    self.removeKeyValueObserver(self.keyValueObservers[i], object: object)
                    self.keyValueObservers.removeAtIndex(i)
                }
            }
        }
    }
    
    // These should not be called directly
    private func removeKeyValueObserver(observer: MCKeyValueObserver, object: AnyObject) {
        self.removeKeyValueObserver(object, observer: observer.observer!, keyPath: observer.keyPath, context: observer.context)
    }
    
    private func removeKeyValueObserver(object: AnyObject, observer: AnyObject, keyPath: String?, context: UnsafeMutablePointer<Void>?) {
        if let con = context {
            object.removeObserver(observer as! NSObject, forKeyPath: keyPath!, context: con)
        } else {
            object.removeObserver(observer as! NSObject, forKeyPath: keyPath!, context: nil)
        }
        
    }
    
    // MARK: Check KVO
    
    // Check if we are observing a particular keypath for an object
    func isKeyValueObserving(object: AnyObject, keyPath: String) -> Bool {
        for obs in self.keyValueObservers {
            if obs.object!.isEqual(object) && obs.keyPath == keyPath {
                return true
            }
        }
        return false
    }
    
    // Check if a class is registered as an observer for an object
    func isKeyValueObserver(observer: AnyObject, object: AnyObject) -> Bool {
        for obs in self.keyValueObservers {
            if let obsobj = obs.object, obsobs = obs.observer {
                if obsobj.isEqual(object) && obsobs.isEqual(observer) {
                    return true
                }
            }
        }
        return false
    }
    
    // Return all the observers currently on an object
    func keyValueObserversForObject(object: AnyObject) -> [MCKeyValueObserver] {
        var observers = [MCKeyValueObserver]()
        for obs in self.keyValueObservers {
            if obs.object!.isEqual(object) {
                observers.append(obs)
            }
        }
        return observers
    }
    
    // MARK: - Notification
    
    // Post a notification only if an observer is listening
    func postNotification(notification: NSNotification, isListening observer: AnyObject) {
        if self.isObserverForName(notification.name, observer: observer) {
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
    func postNotification(aName: String, object: AnyObject?, isListening observer: AnyObject) {
        if self.isObserverForName(aName, observer: observer) {
            NSNotificationCenter.defaultCenter().postNotificationName(aName, object: object)
        }
    }
    
    func postNotification(aName: String, object: AnyObject?, userInfo: [NSObject : AnyObject]?, isListening observer: AnyObject) {
        if self.isObserverForName(aName, observer: observer) {
            NSNotificationCenter.defaultCenter().postNotificationName(aName, object: object, userInfo: userInfo)
        }
    }
    
    // Post a notification if there is at least one listener (hasListener = true) or post always (hasListener = false)
    func postNotification(notification: NSNotification, hasListener: Bool) {
        if hasListener {
            if notificationHasObserver(notification) {
                NSNotificationCenter.defaultCenter().postNotification(notification)
            }
        } else {
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
    func postNotification(aName: String, object: AnyObject?, hasListener: Bool) {
        if hasListener {
            if notificationHasObserver(notificationName: aName) {
                NSNotificationCenter.defaultCenter().postNotificationName(aName, object: object)
            }
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName(aName, object: object)
        }
    }
    
    func postNotification(aName: String, object: AnyObject?, userInfo: [NSObject : AnyObject]?, hasListener: Bool) {
        if hasListener {
            if notificationHasObserver(notificationName: aName) {
                NSNotificationCenter.defaultCenter().postNotificationName(aName, object: object, userInfo: userInfo)
            }
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName(aName, object: object, userInfo: userInfo)
        }
    }
    
    
    // Returns true if there is an observer for a notification
    func notificationHasObserver(notification: NSNotification) -> Bool {
        for obs in self.observers {
            if let aName = obs.name {
                if aName == notification.name {
                    return true
                }
            }
        }
        return false
    }
    
    // Returns true if there is an observer for a notification with name
    func notificationHasObserver(notificationName name: String) -> Bool {
        for obs in self.observers {
            if let aName = obs.name {
                if aName == name {
                    return true
                }
            }
        }
        return false
    }
    
}


// MARK: - Struct

// Observer for general notifications
struct MCObserver {
    var observer: AnyObject?
    var selector: Selector?
    var name: String?
    var object: AnyObject?
    var block: ((NSNotification!) -> Void)?
    var queue: NSOperationQueue?
}

// Key value observer for KVO
struct MCKeyValueObserver {
    var observer: NSObject?
    var object: NSObject?
    var keyPath: String?
    var options: NSKeyValueObservingOptions?
    var context: UnsafeMutablePointer<Void>?
    var block: (() -> ())?
}
