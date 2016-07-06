//
//  ModernUpperNotificationAnimator.swift
//  Pods
//
//  Created by muukii on 7/6/16.
//
//

import Foundation
import UpperNotificationController

public struct ModernUpperNotificationAnimator: UpperNotificationAnimatorType {
    
    public init() {
        
    }
    
    public func applyPresentAnimation<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, completion: () -> Void) {
        
        notificationView.transform = CGAffineTransformMakeTranslation(0, -notificationView.bounds.height)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            
            notificationView.transform = CGAffineTransformIdentity
            
        }) { (finish) in
            
            completion()
        }
    }
    
    public func applyDismissAnimation<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, completion: () -> Void) {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            
            notificationView.transform = CGAffineTransformMakeTranslation(0, -notificationView.bounds.height)
            
        }) { (finish) in
            
            completion()
        }
    }
}