//
//  SecondController.swift
//  STPopup
//
//  Created by 伯驹 黄 on 2016/12/5.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class SecondController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        contentSizeInPopup = CGSize(width: 300 * scaleW, height: 200 * scaleH)
        landscapeContentSizeInPopup = CGSize(width: 400 * scaleH, height: 200 * scaleW)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
