//
//  STPopupControllerTransitioningContext.swift
//  STPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class STPopupControllerTransitioningContext: NSObject {
    var action: STPopupControllerTransitioningAction = .present
    var containerView: UIView?

    init(containerView: UIView, action: STPopupControllerTransitioningAction) {
        super.init()
        self.containerView = containerView
        self.action = action
    }
}
