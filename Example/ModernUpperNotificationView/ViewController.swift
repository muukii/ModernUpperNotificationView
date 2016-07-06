//
//  ViewController.swift
//  ModernUpperNotificationViewDemo
//
//  Created by muukii on 7/6/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import UIKit

import TextAttributesUtil
import TextAttributes

import UpperNotificationController
import ModernUpperNotificationView

class ViewController: UIViewController {
    
    let notificationController = UpperNotificationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationController.windowLevel = UIWindowLevelStatusBar
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func success(sender: AnyObject) {
        
        let notification = NotificationContext<ModernUpperNotificationView> {
            let view = ModernUpperNotificationView(
                attributedText: "Success!".attributed {
                    TextAttributes()
                        .foregroundColor(UIColor.darkGrayColor())
                },
                iconImage: UIImage(named: "OvalBlue")!,
                tap: {
                    print("tap: success")
            })            
            return view
        }
        
        notificationController.deliver(notification: notification)
    }
    
    @IBAction func failure(sender: AnyObject) {
        
        let notification = NotificationContext<ModernUpperNotificationView> {
            let view = ModernUpperNotificationView(
                attributedText: "Failure...".attributed {
                    TextAttributes()
                        .foregroundColor(UIColor.darkGrayColor())
                },
                iconImage: UIImage(named: "OvalRed")!,
                tap: {
                    print("tap: failure")
            })
            return view
        }
        
        notificationController.deliver(notification: notification)
    }

    
    @IBAction func warning(sender: AnyObject) {
        
        let notification = NotificationContext<ModernUpperNotificationView> {
            let view = ModernUpperNotificationView(
                attributedText: "Warning: ".attributed {
                    TextAttributes()
                        .foregroundColor(UIColor.darkGrayColor())
                },
                iconImage: UIImage(named: "OvalGreen")!,
                tap: {
                    print("tap: waring")
            })
            return view
        }
        
        notificationController.deliver(notification: notification)
    }
}
