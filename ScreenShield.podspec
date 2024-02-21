#
# Be sure to run `pod lib lint ScreenShield.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScreenShield'
  s.version          = '1.2.1'
  s.summary          = 'ScreenShield protects sensitive information on iOS screens'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  ScreenShield is a library that helps protect sensitive information on iOS screens by obscuring the content when the user navigates away from the app or the screen is locked. It offers various customizable options and can be easily integrated into your app.
  DESC
  
  s.homepage         = 'https://github.com/JayantBadlani/ScreenShield'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jayant Badlani' => 'badlanijayant9@gmail.com' }
  s.source           = { :git => 'https://github.com/JayantBadlani/ScreenShield.git', :tag => s.version.to_s}
  
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.ios.deployment_target = '14.0'
  
  s.source_files = 'Source/*.swift'
 # s.source_files = 'Sources/ScreenShield/Classes/**/*.{h,m,swift}'
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'ScreenShield' => ['ScreenShield/Assets/*.png']
  # }
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit','SwiftUI'
  # s.dependency 'AFNetworking', '~> 2.3'
end

