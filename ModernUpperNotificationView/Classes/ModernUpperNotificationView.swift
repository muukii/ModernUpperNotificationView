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
import GCDKit

public extension UpperNotificationController {
    
    public func deliver(notification notification: NotificationContext<ModernUpperNotificationView>) {
        
        deliver(notification: notification, animator: ModernUpperNotificationAnimator())
    }
}

public final class ModernUpperNotificationView: UIView, UpperNotificationViewType {
    
    public var tap: (() -> Void)?
    
    public var effect: UIVisualEffect? {
        get {
            return visualEffectView.effect
        }
        set {
            visualEffectView.effect = newValue
        }
    }
    
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
    
    public var textColor: UIColor? {
        get {
            return textLabel.textColor
        }
        set {
            textLabel.textColor = newValue
        }
    }
    
    public var font: UIFont? {
        get {
            return textLabel.font
        }
        set {
            textLabel.font = newValue
        }
    }
    
    public var textAlignment: NSTextAlignment {
        get {
            return textLabel.textAlignment
        }
        set {
            textLabel.textAlignment = newValue
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
    
    public convenience init(attributedText: NSAttributedString, iconImage: UIImage, tap: () -> Void) {
        self.init()
        self.attributedText = attributedText
        self.iconImage = iconImage
        self.tap = tap
    }
    
    public convenience init(text: String, iconImage: UIImage, tap: () -> Void) {
        self.init()
        self.text = text
        self.iconImage = iconImage
        self.tap = tap
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupGesture()
    }
    
    public override func layoutSublayersOfLayer(layer: CALayer) {
        super.layoutSublayersOfLayer(layer)
        
        shadowLayer.masksToBounds = false
        shadowLayer.frame = visualEffectView.layer.frame
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 0.2).CGColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowRadius = 5
        shadowLayer.shadowPath = UIBezierPath(roundedRect: visualEffectView.layer.bounds, cornerRadius: visualEffectView.layer.cornerRadius).CGPath
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func didPrepare(dismissClosure: () -> Void) {
        
        self.dismissClosure = dismissClosure
        GCDBlock.after(.Main, delay: 2) {
            guard self.dragging == false else {
                return
            }
            dismissClosure()
            self.dismissClosure = nil
        }
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
    private let shadowLayer = CALayer()
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
    private var dismissClosure: (() -> Void)?
    private var dragging: Bool = false
    
    private func setupView() {
        self.layer.addSublayer(shadowLayer)
        
        backgroundColor = UIColor.clearColor()
        
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
        
        visualEffectView.contentView.addSubview(textLabel)
        visualEffectView.contentView.addSubview(iconImageView)
        
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
    
    private func setupGesture() {
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDragGesture(_ :)))
        addGestureRecognizer(dragGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_ :)))
        addGestureRecognizer(tapGesture)
    }
    
    private dynamic func handleTapGesture(gesture: UITapGestureRecognizer) {
        
        if case .Ended = gesture.state {
            tap?()
            tap = nil
            dismissClosure?()
            dismissClosure = nil
        }
    }
    
    private dynamic func handleDragGesture(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .Began:
            
            dragging = true
        case .Ended, .Cancelled:
            
            dragging = false
            
            if self.layer.frame.minY < -(self.layer.frame.height / 3) {
                
                self.dismissClosure?()
                self.dismissClosure = nil
            }
            else {
                
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [.BeginFromCurrentState, .AllowUserInteraction], animations: {
                    
                    self.transform = CGAffineTransformIdentity

                    }, completion: { (finish) in
                        GCDBlock.after(.Main, delay: 2) {
                            guard self.dragging == false else {
                                return
                            }
                            self.dismissClosure?()
                            self.dismissClosure = nil
                        }
                })
            }
        default:
            
            let inView = gesture.translationInView(self)
            self.transform = CGAffineTransformTranslate(self.transform, 0, inView.y)
            
            if self.layer.frame.minY > 0 {
                self.transform = CGAffineTransformIdentity
            }
        }
        
        gesture.setTranslation(CGPoint.zero, inView: self)
    }
}

