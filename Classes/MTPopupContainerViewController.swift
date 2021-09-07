//
//  MTPopupContainerViewController.swift
//  MTPopup
//
//  Created by 伯驹 黄 on 2016/11/6.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

public class MTPopupContainerViewController: UIViewController {

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        guard let presentingViewController = presentingViewController, !children.isEmpty else {
            return super.preferredStatusBarStyle
        }
        return presentingViewController.preferredStatusBarStyle
    }

    override public var childForStatusBarHidden: UIViewController? {
        return children.last
    }

    override public var childForStatusBarStyle: UIViewController? {
        return children.last
    }

    override public func show(_ vc: UIViewController, sender _: Any?) {
        method(vc: vc)
    }

    override public func showDetailViewController(_ vc: UIViewController, sender _: Any?) {
        method(vc: vc)
    }

    private func method(vc: UIViewController) {
        let size = vc.landscapeContentSizeInPopup
        let contentSize = vc.contentSizeInPopup
        if contentSize != .zero || size != .zero {
            let childViewController = children.last
            childViewController?.popupController?.push(vc, animated: true)
        } else {
            present(vc, animated: true, completion: nil)
        }
    }
}
