//
//  Bar.swift
//  
//
//  Created by D on 15/7/1.
//
//

import UIKit

class Foo {
    private var observer: KeyValueObserver?
    private let bar = Bar()
    
    init() {
        observer = KeyValueObserver(object: bar, keyPath: "string", options: .New) {
            [unowned self] change in
            println("bar changed: \(self.bar.string)")
        }
        bar.string = "world"
    }
    
    deinit {
        self.observer = nil
    }
}

class Bar: NSObject {
    dynamic var string = "hello"
}