//
//  BottomSheetController.swift
//  STPopup
//
//  Created by 伯驹 黄 on 2016/12/10.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class BottomSheetController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        contentSizeInPopup = CGSize(width: view.frame.width, height: 300)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
