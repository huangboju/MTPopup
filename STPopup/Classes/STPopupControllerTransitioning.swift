//
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

protocol STPopupControllerTransitioning {
    /** 
     Return duration of transitioning, it will be used to animate transitioning of background view.
     */
    func popupControllerTransitionDuration(_ context: STPopupControllerTransitioningContext) -> TimeInterval
    /** 
     Animate transitioning the container view of popup controller. "completion" need to be called after transitioning is finished.
     Initially "containerView" will be placed at the final position with transform = CGAffineTransformIdentity if it's presenting.
     */
    func popupControllerAnimateTransition(_ context: STPopupControllerTransitioningContext, completion: (() -> Void)?)
}
