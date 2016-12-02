//
//  STPopupNavigationBar.swift
//  STPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

protocol STPopupNavigationTouchEventDelegate {
    func popup(_ navigationBar: STPopupNavigationBar, touchDidMoveWith offset: CGFloat)
    func popup(_ navigationBar: STPopupNavigationBar, touchDidEndWith offset: CGFloat)
}

class STPopupNavigationBar: UINavigationBar {
    var draggable = true
    var touchEventDelegate: STPopupNavigationTouchEventDelegate?

    private var moving = false
    private var movingStartY: CGFloat = 0

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !draggable {
            super.touchesBegan(touches, with: event)
            return
        }
        guard let touch = touches.first else { return }
        if (touch.view == self || touch.view?.superview == self) && !moving {
            moving = true
            movingStartY = touch.location(in: window).y
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !draggable {
            super.touchesMoved(touches, with: event)
            return
        }

        if moving {
            guard let touch = touches.first else { return }
            let offset = touch.location(in: window).y - movingStartY
            touchEventDelegate?.popup(self, touchDidMoveWith: offset)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !draggable {
            super.touchesCancelled(touches, with: event)
            return
        }

        if moving {
            guard let touch = touches.first else { return }
            let offset = touch.location(in: window).y - movingStartY
            movingDidEnd(with: offset)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !draggable {
            super.touchesEnded(touches, with: event)
            return
        }

        if moving {
            guard let touch = touches.first else {
                super.touchesBegan(touches, with: event)
                return
            }
            let offset = touch.location(in: window).y - movingStartY
            movingDidEnd(with: offset)
        }
    }

    private func movingDidEnd(with offset: CGFloat) {
        moving = false
        touchEventDelegate?.popup(self, touchDidEndWith: offset)
    }
}
