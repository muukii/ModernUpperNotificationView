//
//  ViewController.swift
//  ModernUpperNotificationViewDemo
//
//  Created by muukii on 7/6/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import UIKit

import UpperNotificationController
import ModernUpperNotificationView

class ViewController: UIViewController {
    
    let notificationController = UpperNotificationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func notice(sender: AnyObject) {
        
        let notification = NotificationContext<ModernUpperNotificationView> {
            let view = ModernUpperNotificationView()
            view.text = "hello world."
            return view
        }
        
        notificationController.deliver(notification: notification, animator: ModernUpperNotificationAnimator())
    }

}
