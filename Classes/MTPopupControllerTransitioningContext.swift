//
//  MTPopupControllerTransitioningContext.swift
//  MTPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

public class MTPopupControllerTransitioningContext {
    var action: MTPopupControllerTransitioningAction = .present
    var containerView: UIView?

    init(containerView: UIView, action: MTPopupControllerTransitioningAction) {
        self.containerView = containerView
        self.action = action
    }
}
