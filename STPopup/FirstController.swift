//
//  FirstController.swift
//  STPopup
//
//  Created by 伯驹 黄 on 2016/11/14.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class FirstController: UIViewController {

    convenience init(a: Int) {
        self.init()
        contentSizeInPopup = CGSize(width: 300, height: 400)
        landscapeContentSizeInPopup = CGSize(width: 400, height: 200)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        textField.backgroundColor = UIColor.red
        textField.becomeFirstResponder()
        view.addSubview(textField)

        view.backgroundColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
