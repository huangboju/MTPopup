//
//  UIViewController+MTPopup.swift
//  MTPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

extension UIViewController {
    private struct AssociatedKeys {
        static var landscapeContentSizeInPopupKey: String? = "landscapeContentSizeInPopup"
        static var contentSizeInPopupKey: String? = "contentSizeInPopup"
        static var popupControllerKey: String? = "popupController"
    }

    static let controllerOnceToken = UUID().uuidString

    open override class func initialize() {
        DispatchQueue.once(token: controllerOnceToken) {
            let selectors: [Selector] = [
                #selector(viewDidLoad),
                #selector(present),
                #selector(dismiss),
                #selector(getter: presentedViewController),
                #selector(getter: presentingViewController)
            ]
            selectors.forEach {
                swizzle($0, to: Selector("st_" + $0.description))
            }
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

    func st_presentViewController(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let popupController = popupController else {
            st_presentViewController(viewControllerToPresent, animated: animated, completion: completion)
            return
        }

        let controller = popupController.value(forKey: "containerViewController") as? UIViewController
        controller?.present(viewControllerToPresent, animated: animated, completion: completion)
    }

    func st_dismissViewControllerAnimated(_ animated: Bool, completion: (() -> Void)?) {
        guard let popupController = popupController else {
            st_dismissViewControllerAnimated(animated, completion: completion)
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

    static let screenW = UIScreen.main.bounds.width
    static let screenH = UIScreen.main.bounds.height

    public var contentSizeInPopup: CGSize {
        set {
            var value = newValue
            if value != .zero && value.width == 0 {
                switch UIApplication.shared.statusBarOrientation {
                case .landscapeLeft, .landscapeRight:
                    value.width = UIViewController.screenH
                default:
                    value.width = UIViewController.screenW
                }
            }

            objc_setAssociatedObject(self, &AssociatedKeys.contentSizeInPopupKey, NSValue(cgSize: value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.contentSizeInPopupKey) as? CGSize) ?? .zero
        }
    }

    public var landscapeContentSizeInPopup: CGSize {
        set {
            var value = newValue
            if value != .zero && value.width == 0 {
                switch UIApplication.shared.statusBarOrientation {
                case .landscapeLeft, .landscapeRight:
                    value.width = UIViewController.screenW
                default:
                    value.width = UIViewController.screenH
                }
            }
            objc_setAssociatedObject(self, &AssociatedKeys.landscapeContentSizeInPopupKey, NSValue(cgSize: value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.landscapeContentSizeInPopupKey) as? CGSize) ?? .zero
        }
    }

    public var popupController: MTPopupController? {
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.popupControllerKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }

        get {
            let popupController = objc_getAssociatedObject(self, &AssociatedKeys.popupControllerKey) as? MTPopupController
            guard let controller = popupController else {
                return parent?.popupController
            }
            return controller
        }
    }
}
