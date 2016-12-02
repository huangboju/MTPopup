//
//  UIViewController+STPopup.swift
//  STPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

extension UIViewController {
    private struct AssociatedKeys {
        static var landscapeContentSizeInPopupKey = "landscapeContentSizeInPopup"
        static var contentSizeInPopupKey = "contentSizeInPopup"
        static var popupControllerKey = "popupController"
    }

    static let controllerOnceToken = UUID().uuidString

    open override class func initialize() {
        DispatchQueue.once(token: controllerOnceToken) {
            swizzle(#selector(viewDidLoad), to: #selector(st_viewDidLoad))
            swizzle(#selector(present(_:animated:completion:)), to: #selector(st_present(_:animated:completion:)))
            swizzle(#selector(dismiss(animated:completion:)), to: #selector(st_dismiss(animated:completion:)))
            swizzle(#selector(getter: presentedViewController), to: #selector(getter: st_presentedViewController))
            swizzle(#selector(getter: presentingViewController), to: #selector(getter: st_presentingViewController))
        }
    }

    class func swizzle(_ originalSelector: Selector, to swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }

    func st_viewDidLoad() {
        var contentSize = CGSize.zero
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft, .landscapeRight:
            contentSize = landscapeContentSizeInPopup
            if contentSize == .zero {
                contentSize = contentSizeInPopup
            }
        default:
            contentSize = contentSizeInPopup
        }

        if contentSize != .zero {
            view.frame = CGRect(origin: .zero, size: contentSize)
        }
        st_viewDidLoad()
    }

    func st_present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let popupController = popupController else {
            st_present(viewControllerToPresent, animated: animated, completion: completion)
            return
        }

        let controller = popupController.value(forKey: "containerViewController") as? UIViewController
        controller?.present(viewControllerToPresent, animated: animated, completion: completion)
    }

    func st_dismiss(animated: Bool, completion: (() -> Void)?) {
        guard let popupController = popupController else {
            st_dismiss(animated: animated, completion: completion)
            return
        }

        popupController.dismiss(with: completion)
    }

    var st_presentedViewController: UIViewController? {
        guard let popupController = popupController else { return self.st_presentedViewController }

        let controller = popupController.value(forKey: "containerViewController") as? UIViewController
        return controller?.presentedViewController
    }

    var st_presentingViewController: UIViewController? {
        guard let popupController = popupController else { return self.st_presentingViewController }
        let controller = popupController.value(forKey: "containerViewController") as? UIViewController
        return controller?.presentingViewController
    }

    var contentSizeInPopup: CGSize {
        set {
            var value = newValue
            if value != .zero && value.width == 0 {
                switch UIApplication.shared.statusBarOrientation {
                case .landscapeLeft, .landscapeRight:
                    value.width = UIScreen.main.bounds.height
                default:
                    value.width = UIScreen.main.bounds.height
                }
            }
  
            objc_setAssociatedObject(self, &AssociatedKeys.contentSizeInPopupKey, NSValue(cgSize: value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.contentSizeInPopupKey) as? CGSize) ?? .zero
        }
    }

    var landscapeContentSizeInPopup: CGSize {
        set {

            var value = newValue
            if value != .zero && value.width == 0 {
                switch UIApplication.shared.statusBarOrientation {
                case .landscapeLeft, .landscapeRight:
                    value.width = UIScreen.main.bounds.width
                default:
                    value.width = UIScreen.main.bounds.height
                }
            }
            objc_setAssociatedObject(self, &AssociatedKeys.landscapeContentSizeInPopupKey, NSValue(cgSize: value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.landscapeContentSizeInPopupKey) as? CGSize) ?? .zero
        }
    }

    var popupController: STPopupController? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.popupControllerKey, newValue!, .OBJC_ASSOCIATION_ASSIGN)
        }

        get {
            let popupController = objc_getAssociatedObject(self, &AssociatedKeys.popupControllerKey) as? STPopupController
            guard let controller = popupController else {
                return parent?.popupController
            }
            return controller
        }
    }
}
