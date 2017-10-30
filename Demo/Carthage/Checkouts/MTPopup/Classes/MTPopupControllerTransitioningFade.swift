//
//  MTPopupControllerTransitioningFade.swift
//  MTPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

class MTPopupControllerTransitioningFade: MTPopupControllerTransitioning {

    func popupControllerAnimateTransition(_ context: MTPopupControllerTransitioningContext, completion: (() -> Void)?) {
        let containerView = context.containerView
        let duration = popupControllerTransitionDuration(context)

        if context.action == .present {
            containerView?.alpha = 0
            containerView?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)

            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
                containerView?.alpha = 1
                containerView?.transform = CGAffineTransform.identity
            }, completion: { _ in
                completion?()
            })
        } else {
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
                containerView?.alpha = 0
            }, completion: { _ in
                containerView?.alpha = 1
                completion?()
            })
        }
    }
}
