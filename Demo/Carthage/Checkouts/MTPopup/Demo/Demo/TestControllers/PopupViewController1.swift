//
//  FirstController.swift
//  STPopup
//
//  Created by 伯驹 黄 on 2016/11/14.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

let scaleW = UIScreen.main.bounds.width / 320
let scaleH = UIScreen.main.bounds.height / 568

class PopupViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Apple"

        contentSizeInPopup = CGSize(width: 280 * scaleW, height: 380 * scaleH)
        landscapeContentSizeInPopup = CGSize(width: 400 * scaleH, height: 200 * scaleW)

        view.backgroundColor = UIColor.groupTableViewBackground

        let textLabel = UILabel(frame: CGRect(x: 15, y: 0, width: contentSizeInPopup.width - 30, height: 380))
        textLabel.numberOfLines = 0
        textLabel.text = "Apple Inc. (commonly known as Apple) is an American multinational technology company headquartered in Cupertino, California, that designs, develops, and sells consumer electronics, computer software, and online services. Its best-known hardware products are the Mac personal computers, the iPod portable media player, the iPhone smartphone, the iPad tablet computer, and the Apple Watch smartwatch. Apple's consumer software includes the OS X and iOS operating systems, the iTunes media player, the Safari web browser, and the iLife and iWork creativity and productivity suites. Its online services include the iTunes Store, the iOS App Store and Mac App Store, and iCloud."
        view.addSubview(textLabel)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction))
    }

    func nextAction() {
        popupController?.push(PopupViewController2(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
