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
    
    public func applyPresentAnimation<T>(notificationView: T, completion: @escaping () -> Void) where T: UpperNotificationViewType, T: UIView {
        
        notificationView.transform = CGAffineTransform(translationX: 0, y: -notificationView.bounds.height)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            
            notificationView.transform = .identity
            
        }) { (finish) in
            
            completion()
        }
    }
    
    public func applyDismissAnimation<T>(notificationView: T, completion: @escaping () -> Void) where T: UpperNotificationViewType, T: UIView {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            
            notificationView.transform = CGAffineTransform(translationX: 0, y: -notificationView.bounds.height)
            
        }) { (finish) in
            
            completion()
        }
    }
}
