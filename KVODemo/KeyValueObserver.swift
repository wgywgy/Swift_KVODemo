//
//  KeyValueObserver.swift
//  
//
//  Created by D on 15/7/1.
//
//

import UIKit

class KeyValueObserver: NSObject {
    typealias KeyValueObservingCallback = (change: [NSObject : AnyObject]) -> Void
    
    private let object: NSObject
    private let keyPath: String
    private let callback: KeyValueObservingCallback
    private var kvoContext = 0
    
    init(object: NSObject, keyPath: String, options: NSKeyValueObservingOptions, callback: KeyValueObservingCallback) {
        self.object = object
        self.keyPath = keyPath
        self.callback = callback
        super.init()
        object.addObserver(self, forKeyPath: keyPath, options: options, context: &kvoContext)
    }
    
    deinit {
        object.removeObserver(self, forKeyPath: keyPath, context: &kvoContext)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if context == &kvoContext {
            self.callback(change: change)
        }
        else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
}
