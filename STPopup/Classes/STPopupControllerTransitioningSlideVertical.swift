//
//  STPopupControllerTransitioningSlideVertical.swift
//  STPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class STPopupControllerTransitioningSlideVertical: NSObject, STPopupControllerTransitioning {

    func popupControllerTransitionDuration(_ context: STPopupControllerTransitioningContext) -> TimeInterval {
        return context.action == .present ? 0.5 : 0.35
    }

    func popupControllerAnimateTransition(_ context: STPopupControllerTransitioningContext, completion: (() -> Void)?) {
        guard let containerView = context.containerView else { return }
        let duration = popupControllerTransitionDuration(context)
        if context.action == .present {
            containerView.transform = CGAffineTransform(translationX: 0, y: containerView.superview!.bounds.height - containerView.frame.minY)

            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                containerView.transform = CGAffineTransform.identity
            }, completion: { (flag) in
                completion?()
            })
        } else {
            let lastTransform = containerView.transform
            containerView.transform = CGAffineTransform.identity
            let originY = containerView.frame.minY
            containerView.transform = lastTransform

            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
                containerView.transform = CGAffineTransform(translationX: 0, y: containerView.superview!.bounds.height - originY + containerView.frame.height)
            }, completion: { (flag) in
                containerView.transform = CGAffineTransform.identity
                completion?()
            })
        }
    }
}
