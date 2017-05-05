#
# Be sure to run `pod lib lint ShockExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ShockExtension'
  s.version          = '0.1.2'
  s.summary          = 'Frequently used basic extensions'
  s.description      = <<-DESC
Frequently used basic extensions
UIAlertController
String
Int
                       DESC

  s.homepage         = 'https://github.com/ShockUtility/ShockExtension'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ShockUtility' => 'shock@docs.kr' }
  s.source           = { :git => 'https://github.com/ShockUtility/ShockExtension.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.source_files = 'ShockExtension/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ShockExtension' => ['ShockExtension/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
