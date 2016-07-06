//
//  ModernUpperNotificationView.swift
//  Pods
//
//  Created by muukii on 7/6/16.
//
//

import Foundation
import UpperNotificationController
import Cartography

public class ModernUpperNotificationView: UIView, UpperNotificationViewType {
    
    public var iconImage: UIImage? {
        get {
            return iconImageView.image
        }
        set {
            iconImageView.image = newValue
        }
    }
    
    public var text: String? {
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
        }
    }
    
    public var attributedText: NSAttributedString? {
        get {
            return textLabel.attributedText
        }
        set {
            textLabel.attributedText = newValue
        }
    }
    
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 320, height: 54))
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
        visualEffectView.layer.masksToBounds = true
        visualEffectView.layer.cornerRadius = 12
        
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(visualEffectView)
        
        constrain(visualEffectView) {
            let superview = $0.superview!
            
            $0.top == superview.top + 8
            $0.right == superview.right - 8
            $0.bottom == superview.bottom - 8
            $0.left == superview.left + 8
            
            $0.height == 54
        }
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .Center
        
        visualEffectView.addSubview(textLabel)
        visualEffectView.addSubview(iconImageView)
        
        constrain(iconImageView, textLabel) { iconImageView, textLabel in
            let superview = iconImageView.superview!
        
            iconImageView.width == 32
            iconImageView.height == iconImageView.height
            iconImageView.left == superview.left + 17
            iconImageView.centerY == superview.centerY
            
            textLabel.left == iconImageView.right + 10
            textLabel.right == superview.right - 17
            textLabel.centerY == superview.centerY
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func didPrepare(dismissClosure: () -> Void) {
        
    }
    
    public func willAppear() {
        
    }
    
    public func didAppear() {
        
    }
    
    public func willDisappear() {
        
    }
    
    public func didDisappear() {
        
    }
    
    // MARK: - Private
    
    private let textLabel = UILabel()
    private let iconImageView = UIImageView()
}
