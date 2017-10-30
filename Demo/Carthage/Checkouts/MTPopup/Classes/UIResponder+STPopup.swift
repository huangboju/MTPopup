//
//  UIResponder+MTPopup.swift
//  MTPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

let MTPopupFirstResponderDidChange = Notification.Name(rawValue: "MTPopupFirstResponderDidChange")

extension UIResponder {

    static let _onceToken = UUID().uuidString

    open override class func initialize() {

        DispatchQueue.once(token: _onceToken) {
            swizzle(selector: #selector(becomeFirstResponder), to: #selector(st_becomeFirstResponder))
        }
    }

    class func swizzle(selector: Selector, to swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, selector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }

    func st_becomeFirstResponder() -> Bool {
        let accepted = st_becomeFirstResponder()
        if accepted {
            NotificationCenter.default.post(name: MTPopupFirstResponderDidChange, object: self)
        }
        return accepted
    }
}

extension DispatchQueue {

    private static var _onceTracker = [String]()

    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }
}
