//
//  ViewController.swift
//  STPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit
import MTPopup

class ViewController: UIViewController {

    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    lazy var controllers: [UIViewController.Type] = [
        PopupViewController1.self,
        PopupViewController1.self,
        BottomSheetController.self
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MTPopupController"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = "\(controllers[indexPath.row].classForCoder())"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        let popupController = MTPopupController(rootViewController: controllers[indexPath.row].init())

        if indexPath == IndexPath(row: 1, section: 0) {
            let blurEffect = UIBlurEffect(style: .dark)
            popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
            popupController.backgroundView?.alpha = 0.8
        } else if indexPath == IndexPath(row: 2, section: 0) {
            popupController.style = .bottomSheet
        }
        popupController.present(in: self)
    }
}
