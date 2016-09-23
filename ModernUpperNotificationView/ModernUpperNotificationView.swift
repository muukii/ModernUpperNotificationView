//
//  ModernUpperNotificationView.swift
//  Pods
//
//  Created by muukii on 7/6/16.
//
//

import Foundation

import EasyPeasy
import UpperNotificationController

public extension UpperNotificationController {
    
    public func deliver(notification: NotificationContext<ModernUpperNotificationView>) {
        
        deliver(notification: notification, animator: ModernUpperNotificationAnimator())
    }
}

public final class ModernUpperNotificationView: UIView, UpperNotificationViewType {
    
    public var tap: (() -> Void)?
    
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
    
    public convenience init(attributedText: NSAttributedString, iconImage: UIImage, tap: @escaping () -> Void) {
        self.init()
        self.attributedText = attributedText
        self.iconImage = iconImage
        self.tap = tap
    }
    
    public convenience init(text: String, iconImage: UIImage, tap: @escaping () -> Void) {
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
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        shadowLayer.masksToBounds = false
        shadowLayer.frame = visualEffectView.layer.frame
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 0.2).cgColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowRadius = 5
        shadowLayer.shadowPath = UIBezierPath(roundedRect: visualEffectView.layer.bounds, cornerRadius: visualEffectView.layer.cornerRadius).cgPath
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func didPrepare(_ dismissClosure: @escaping () -> Void) {
        
        self.dismissClosure = dismissClosure
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
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
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    private var dismissClosure: (() -> Void)?
    private var dragging: Bool = false
    
    private func setupView() {
        self.layer.addSublayer(shadowLayer)
        
        backgroundColor = UIColor.clear
        
        visualEffectView.layer.masksToBounds = true
        visualEffectView.layer.cornerRadius = 12
        
        addSubview(visualEffectView)
        
        visualEffectView <- [
            Edges(8),
            Height(54),
        ]
        
        iconImageView.contentMode = .center
        
        visualEffectView.addSubview(textLabel)
        visualEffectView.addSubview(iconImageView)
        
        
        iconImageView <- [
            Size(32),
            Left(17),
            CenterY(),
        ]
        
        textLabel <- [
            Left(10).to(iconImageView, .right),
            Right(17),
            CenterY(),
        ]

    }
    
    private func setupGesture() {
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(ModernUpperNotificationView.handleDragGesture(gesture :)))
        addGestureRecognizer(dragGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ModernUpperNotificationView.handleTapGesture(gesture:)))
        addGestureRecognizer(tapGesture)
    }
    
    private dynamic func handleTapGesture(gesture: UITapGestureRecognizer) {
        
        if case .ended = gesture.state {
            tap?()
            tap = nil
            dismissClosure?()
            dismissClosure = nil
        }
    }
    
    private dynamic func handleDragGesture(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            
            dragging = true
        case .ended, .cancelled:
            
            dragging = false
            
            if self.layer.frame.minY < -(self.layer.frame.height / 3) {
                
                self.dismissClosure?()
                self.dismissClosure = nil
            }
            else {
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                    
                    self.transform = .identity

                    }, completion: { (finish) in
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                            guard self.dragging == false else {
                                return
                            }
                            self.dismissClosure?()
                            self.dismissClosure = nil
                        }
                })
            }
        default:
            
            let inView = gesture.translation(in: self)
            transform = transform.translatedBy(x: 0, y: inView.y)
            
            if self.layer.frame.minY > 0 {
                self.transform = .identity
            }
        }
        
        gesture.setTranslation(CGPoint.zero, in: self)
    }
}

