//
//  ViewController.swift
//  MCNotificationCenter
//
//  Created by Max Campolo on 5/11/15.
//  Copyright (c) 2015 Max Campolo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mStepper: UIStepper!
    
    var NOTE_1 = "Notification1"
    var NOTE_2 = "Notification2"
    var NOTE_3 = "Notification3"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.registerObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerObservers() {
        MCNotificationCenter.defaultCenter.addObserver(self, selector: Selector("printNotification:"), name: NOTE_1, object: nil)
        MCNotificationCenter.defaultCenter.addObserver(self, selector: Selector("printNotification:"), name: NOTE_2, object: nil)
        MCNotificationCenter.defaultCenter.addObserver(self, selector: Selector("printNotification:"), name: NOTE_3, object: nil)
        
        weak var weakSelf = self
        MCNotificationCenter.defaultCenter.addKeyValueObserver(MCNotificationCenter.defaultCenter, onObject: self.mStepper, forKeyPath: "value", options: .New, context: nil) { () -> () in
            if let wSelf = weakSelf {
                println(wSelf.mStepper.value)
            }
        }
        
    }
    
    func printNotification(sender: NSNotification) {
        if sender.name == NOTE_1 {
            println(NOTE_1)
        } else if sender.name == NOTE_2 {
            println(NOTE_2)
        } else {
            println(NOTE_3)
        }
    }
    
    func printNotificationObservers() {
        let currentObservers = MCNotificationCenter.defaultCenter.observersForObserver(self)
        for item in currentObservers {
            println(item.name)
        }
    }
    
    // MARK: Post Notifications
    
    @IBAction func sendNotification1(sender: AnyObject) {
        if MCNotificationCenter.defaultCenter.isObserverForName(NOTE_1, observer: self) {
            MCNotificationCenter.defaultCenter.postNotification(NOTE_1, object: nil, hasListener: true)
        } else {
            println("Not registered as oberver for Notification 1")
        }
    }
    
    @IBAction func sendNotification2(sender: AnyObject) {
        MCNotificationCenter.defaultCenter.postNotification(NOTE_2, object: nil, hasListener: true)
    }

    @IBAction func sendNotification3(sender: AnyObject) {
        MCNotificationCenter.defaultCenter.postNotification(NOTE_3, object: nil, hasListener: false)
    }
    
    // MARK: Register Notifications
    
    @IBAction func registerNotification1(sender: AnyObject) {
        if !MCNotificationCenter.defaultCenter.isObserverForName(NOTE_1, observer: self) {
            MCNotificationCenter.defaultCenter.addObserver(self, selector: Selector("printNotification:"), name: NOTE_1, object: nil)
        }
        
        self.printNotificationObservers()
    }
    
    @IBAction func registerNotifiation2(sender: AnyObject) {
        if !MCNotificationCenter.defaultCenter.isObserverForName(NOTE_2, observer: self) {
            MCNotificationCenter.defaultCenter.addObserver(self, selector: Selector("printNotification:"), name: NOTE_2, object: nil)
        }
        
        self.printNotificationObservers()
    }
    
    @IBAction func registerNotification3(sender: AnyObject) {
        if !MCNotificationCenter.defaultCenter.isObserverForName(NOTE_3, observer: self) {
            MCNotificationCenter.defaultCenter.addObserver(self, selector: Selector("printNotification:"), name: NOTE_3, object: nil)
        }
        
        self.printNotificationObservers()
    }
    
    // MARK: Remove Notifications
    
    @IBAction func removeNotification1(sender: AnyObject) {
        if MCNotificationCenter.defaultCenter.isObserverForName(NOTE_1, observer: self) {
            MCNotificationCenter.defaultCenter.removeObserverWithName(NOTE_1, observer: self)
        }
        self.printNotificationObservers()
    }
    
    @IBAction func removeNotification2(sender: AnyObject) {
        MCNotificationCenter.defaultCenter.removeObserverWithName(NOTE_2, observer: self)
        
        self.printNotificationObservers()
    }
    
    @IBAction func removeNotification3(sender: AnyObject) {
        MCNotificationCenter.defaultCenter.removeObserverWithName(NOTE_3, observer: self)
        
        self.printNotificationObservers()
    }
    
    @IBAction func removeKeyValueObserver(sender: AnyObject) {
        if MCNotificationCenter.defaultCenter.isKeyValueObserving(self.mStepper, keyPath: "value") {
            //MCNotificationCenter.defaultCenter.removeKeyValueObserver(self.mStepper, keyPath: "value")
            mStepper.removeObserver("value")
            println("Removed observer: value, for stepper")
        } else {
            weak var weakSelf = self
//            MCNotificationCenter.defaultCenter.addKeyValueObserver(MCNotificationCenter.defaultCenter, onObject: mStepper, forKeyPath: "value", options: .New, context: nil, usingBlock: { () -> () in
//                if let wSelf = weakSelf {
//                    println(wSelf.mStepper.value)
//                }
//            })
            mStepper.addObserver("value", usingBlock: { () -> () in
                println(self.mStepper.value)
            })
            println("Added observer: value, for stepper")
        }
        
    }
    

}

