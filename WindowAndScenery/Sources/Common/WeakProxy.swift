//
//  WeakProxy.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/20.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class WeakProxy: NSObject {
    weak var target: NSObject?
    
    convenience init(_ target: NSObject?) {
        self.init()
        
        self.target = target
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return target
    }
}
