# ModernUpperNotificationView

[![CI Status](http://img.shields.io/travis/muukii/ModernUpperNotificationView.svg?style=flat)](https://travis-ci.org/muukii/ModernUpperNotificationView)
[![Version](https://img.shields.io/cocoapods/v/ModernUpperNotificationView.svg?style=flat)](http://cocoapods.org/pods/ModernUpperNotificationView)
[![License](https://img.shields.io/cocoapods/l/ModernUpperNotificationView.svg?style=flat)](http://cocoapods.org/pods/ModernUpperNotificationView)
[![Platform](https://img.shields.io/cocoapods/p/ModernUpperNotificationView.svg?style=flat)](http://cocoapods.org/pods/ModernUpperNotificationView)

ModernUpperNotificationView is simple notification view.
powered by [UpperNotificationController](https://github.com/muukii/UpperNotificationController)

![](sample.gif)
![](sample1.png)
![](sample2.png)
![](sample3.png)


## Example

```swift
let notificationController = UpperNotificationController()
notificationController.windowLevel = UIWindowLevelStatusBar

let notification = NotificationContext<ModernUpperNotificationView> {
    let view = ModernUpperNotificationView(
        text: "Failure...",
        iconImage: UIImage(named: "OvalRed")!,
        tap: {
            print("tap: failure")
    })
    return view
}

notificationController.deliver(notification: notification)
```

## Requirements

iOS 8.0 +

## Installation

ModernUpperNotificationView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ModernUpperNotificationView"
```

## Author

muukii, m@muukii.me

## License

ModernUpperNotificationView is available under the MIT license. See the LICENSE file for more info.
