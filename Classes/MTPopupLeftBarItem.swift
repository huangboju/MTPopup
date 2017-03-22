//
//  MTPopupLeftBarItem.swift
//  MTPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

enum MTPopupLeftBarItemType {
    case cross, arrow
}

class MTPopupLeftBarItem: UIBarButtonItem {
    var type: MTPopupLeftBarItemType = .cross

    private lazy var bar1: UIView = {
        let bar1 = UIView()
        bar1.backgroundColor = UIColor(white: 0.4, alpha: 1)
        bar1.isUserInteractionEnabled = false
        bar1.layer.allowsEdgeAntialiasing = true
        return bar1
    }()

    private lazy var bar2: UIView = {
        let bar2 = UIView()
        bar2.backgroundColor = UIColor(white: 0.4, alpha: 1)
        bar2.isUserInteractionEnabled = false
        bar2.layer.allowsEdgeAntialiasing = true
        return bar2
    }()

    convenience init(with target: Any?, action: Selector) {
        self.init()
        customView = UIControl(frame: CGRect(x: 0, y: 0, width: 18, height: 44))
        (customView as? UIControl)?.addTarget(target, action: action, for: .touchUpInside)

        customView?.addSubview(bar1)

        customView?.addSubview(bar2)
    }

    func set(_ type: MTPopupLeftBarItemType, animated: Bool) {
        self.type = type
        if animated {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.updateLayout()
            }, completion: nil)
        } else {
            updateLayout()
        }
    }

    private func updateLayout() {
        var barWidth: CGFloat = 0
        let barHeight: CGFloat = 1.5
        var barX: CGFloat = 0
        var bar1Y: CGFloat = 0
        var bar2Y: CGFloat = 0
        guard let customView = customView else { return }
        switch type {
        case .cross:
            barWidth = customView.frame.height * 2 / 5
            barX = (customView.frame.width - barWidth) / 2
            bar1Y = (customView.frame.height - barHeight) / 2
            bar2Y = bar1Y
        case .arrow:
            barWidth = customView.frame.height / 4
            barX = (customView.frame.width - barWidth) / 2 - barWidth / 2
            bar1Y = (customView.frame.height - barHeight) / 2 + barWidth / 2 * sin(.pi / 4)
            bar2Y = (customView.frame.height - barHeight) / 2 - barWidth / 2 * sin(.pi / 4)
        }

        bar1.transform = CGAffineTransform.identity
        bar2.transform = CGAffineTransform.identity
        bar1.frame = CGRect(x: barX, y: bar1Y, width: barWidth, height: barHeight)
        bar2.frame = CGRect(x: barX, y: bar2Y, width: barWidth, height: barHeight)

        bar1.transform = CGAffineTransform(rotationAngle: .pi / 4)
        bar2.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4)
    }

    override var tintColor: UIColor? {
        didSet {
            bar1.backgroundColor = tintColor
            bar2.backgroundColor = tintColor
        }
    }
}
