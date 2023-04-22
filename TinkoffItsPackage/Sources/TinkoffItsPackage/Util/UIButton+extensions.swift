//
//  File.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit

public var RUIProxyTargetsKey = "s"

open class RUIProxyTarget : NSObject {
  open class func actionSelector() -> Selector {
        return Selector(("performAction:"))
    }
}

public extension UIButton {
    convenience init(type: ButtonType = .system, forControlEvents events: UIControl.Event = .touchUpInside, action: @escaping (UIControl) -> Void) {
        self.init(type: type)
        addAction(action, forControlEvents: events)
    }
}

public extension UIControl {
    
    convenience init(action: @escaping (UIControl) -> (), forControlEvents events: UIControl.Event) {
        self.init()
        addAction(action, forControlEvents: events)
    }
    
    convenience init(forControlEvents events: UIControl.Event, action: @escaping (UIControl) -> Void) {
        self.init()
        addAction(action, forControlEvents: events)
    }
    
    func addAction(_ action: @escaping (UIControl) -> (), forControlEvents events: UIControl.Event) {
        removeAction(forControlEvents: events)
        
        let proxyTarget = RUIControlProxyTarget(action: action)
        proxyTargets[keyForEvents(events)] = proxyTarget
        addTarget(proxyTarget, action: RUIControlProxyTarget.actionSelector(), for: events)
    }
    
    func forControlEvents(events: UIControl.Event, addAction action: @escaping (UIControl) -> Void) {
        addAction(action, forControlEvents: events)
    }
    
    func removeAction(forControlEvents events: UIControl.Event) {
        if let proxyTarget = proxyTargets[keyForEvents(events)] {
            removeTarget(proxyTarget, action: RUIControlProxyTarget.actionSelector(), for: events)
            proxyTargets.removeValue(forKey: keyForEvents(events))
        }
    }
    
    func actionForControlEvent(events: UIControl.Event) -> ((UIControl) -> Void)? {
        return proxyTargets[keyForEvents(events)]?.action
    }
    
    var actions: [(UIControl) -> Void] {
        return [RUIControlProxyTarget](proxyTargets.values).map { $0.action }
    }
    
}

internal extension UIControl {
    
    typealias RUIControlProxyTargets = [String: RUIControlProxyTarget]
    
    class RUIControlProxyTarget : RUIProxyTarget {
        var action: (UIControl) -> ()
        
        init(action: @escaping (UIControl) -> ()) {
            self.action = action
        }
        
        @objc func performAction(_ control: UIControl) {
            action(control)
        }
        
        override class func actionSelector() -> Selector {
            return #selector(RUIControlProxyTarget.performAction(_:))
        }
    }
    
    func keyForEvents(_ events: UIControl.Event) -> String {
        return "UIControlEvents: \(events.rawValue)"
    }
    
    var proxyTargets: RUIControlProxyTargets {
        get {
            if let targets = objc_getAssociatedObject(self, &RUIProxyTargetsKey) as? RUIControlProxyTargets {
                return targets
            } else {
                return setProxyTargets(RUIControlProxyTargets())
            }
        }
        set {
            setProxyTargets(newValue)
        }
    }
    
    @discardableResult
    private func setProxyTargets(_ newValue: RUIControlProxyTargets) -> RUIControlProxyTargets {
        objc_setAssociatedObject(self, &RUIProxyTargetsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return newValue
    }
}
