//
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

public protocol MTPopupControllerTransitioning {
    /**
     Return duration of transitioning, it will be used to animate transitioning of background view.
     */
    func popupControllerTransitionDuration(_ context: MTPopupControllerTransitioningContext) -> TimeInterval
    /**
     Animate transitioning the container view of popup controller. "completion" need to be called after transitioning is finished.
     Initially "containerView" will be placed at the final position with transform = CGAffineTransformIdentity if it's presenting.
     */
    func popupControllerAnimateTransition(_ context: MTPopupControllerTransitioningContext, completion: (() -> Void)?)
}

extension MTPopupControllerTransitioning {
    func popupControllerTransitionDuration(_ context: MTPopupControllerTransitioningContext) -> TimeInterval {
        if self is MTPopupControllerTransitioningFade {
            return context.action == .present ? 0.25 : 0.2
        } else {
            return context.action == .present ? 0.5 : 0.35
        }
    }
}
