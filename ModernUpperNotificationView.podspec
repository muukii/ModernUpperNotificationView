#
# Be sure to run `pod lib lint ModernUpperNotificationView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ModernUpperNotificationView'
  s.version          = '0.3.0'
  s.summary          = 'Simple notification view in app. Powered by UpperNotificationController'
  s.homepage         = 'https://github.com/muukii0803/ModernUpperNotificationView'
  s.screenshots      = 'https://raw.githubusercontent.com/muukii/ModernUpperNotificationView/master/sample1.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'muukii' => 'm@muukii.me' }
  s.source           = { :git => 'https://github.com/muukii/ModernUpperNotificationView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/muukii0803'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ModernUpperNotificationView/**/*.swift'

  s.dependency 'UpperNotificationController', '~> 0.1.0'
  s.dependency 'EasyPeasy'
end
