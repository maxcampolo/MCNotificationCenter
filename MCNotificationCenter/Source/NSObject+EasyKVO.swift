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

extension NSObject {
    
    // MARK: - KVO Convenience
    
    func addObserver(keypath: String, usingBlock block:() -> ()) {
        MCNotificationCenter.defaultCenter.addKeyValueObserver(MCNotificationCenter.defaultCenter, onObject: self, forKeyPath: keypath, options: nil, context: nil, usingBlock: block)
    }
    
    func addObserver(keypath: String, options: NSKeyValueObservingOptions, context: UnsafeMutablePointer<Void>, usingBlock block:() -> ()) {
        MCNotificationCenter.defaultCenter.addKeyValueObserver(MCNotificationCenter.defaultCenter, onObject: self, forKeyPath: keypath, options: options, context: context, usingBlock: block)
    }
    
    func removeObserver(keypath: String) {
        MCNotificationCenter.defaultCenter.removeKeyValueObserver(self, keyPath: keypath)
    }
    
    func removeKeyValueObservers() {
        MCNotificationCenter.defaultCenter.removeKeyValueObserversForObject(self)
    }
    
    func myKeyValueObservers() -> [MCKeyValueObserver] {
        return MCNotificationCenter.defaultCenter.keyValueObserversForObject(self)
    }
    
    // MARK: - NSNotificationCenter Observing
    
    // Convenience method for returning observers on an object
    func myObservers() -> [MCObserver] {
        return MCNotificationCenter.defaultCenter.observersForObject(self)
    }
    
}
