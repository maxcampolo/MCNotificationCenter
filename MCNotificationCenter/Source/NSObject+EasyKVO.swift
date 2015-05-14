//
//  EasyKVO.swift
//  MCNotificationCenter
//
//  Created by Max Campolo on 5/13/15.
//  Copyright (c) 2015 Max Campolo. All rights reserved.
//

/*
*   This class extends NSObject to accept easy KVO registration in combination with MCNotificationCenter.
*   All KVO convenience methods will assume use of MCNotificationCenter.defaultCenter as the observer class.
*/

import Foundation

public extension NSObject {
    
    // MARK: - KVO Convenience
    
    public func addObserver(keypath: String, usingBlock block:() -> ()) {
        MCNotificationCenter.defaultCenter.addKeyValueObserver(MCNotificationCenter.defaultCenter, onObject: self, forKeyPath: keypath, options: nil, context: nil, usingBlock: block)
    }
    
    public func addObserver(keypath: String, options: NSKeyValueObservingOptions, context: UnsafeMutablePointer<Void>, usingBlock block:() -> ()) {
        MCNotificationCenter.defaultCenter.addKeyValueObserver(MCNotificationCenter.defaultCenter, onObject: self, forKeyPath: keypath, options: options, context: context, usingBlock: block)
    }
    
    public func removeObserver(keypath: String) {
        MCNotificationCenter.defaultCenter.removeKeyValueObserver(self, keyPath: keypath)
    }
    
    public func removeKeyValueObservers() {
        MCNotificationCenter.defaultCenter.removeKeyValueObserversForObject(self)
    }
    
    public func myKeyValueObservers() -> [MCKeyValueObserver] {
        return MCNotificationCenter.defaultCenter.keyValueObserversForObject(self)
    }
    
    // MARK: - NSNotificationCenter Observing
    
    // Convenience method for returning observers on an object
    public func myObservers() -> [MCObserver] {
        return MCNotificationCenter.defaultCenter.observersForObject(self)
    }
    
}
