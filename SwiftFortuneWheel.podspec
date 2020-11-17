Pod::Spec.new do |s|
  s.name         = "SwiftFortuneWheel"
  s.version      = "1.3.0"
  s.summary      = "Ultimate spinning wheel control that supports dynamic content and rich customization."
  s.description  = <<-DESC
  Fortune spinning wheel that supports dynamic content and rich customization. Main Features: Dynamic content, support image, and text; Appearance customization; Drawn and animated using CoreGraphics; Dynamic layout.
  DESC
  s.homepage     = "https://github.com/sh-khashimov/SwiftFortuneWheel.git"
  s.documentation_url = 'https://sh-khashimov.github.io/SwiftFortuneWheel'
  s.screenshots     = 'https://raw.githubusercontent.com/sh-khashimov/SwiftFortuneWheel/master/Images/screenshots/1.png', 'https://raw.githubusercontent.com/sh-khashimov/SwiftFortuneWheel/master/Images/screenshots/2.png', 'https://raw.githubusercontent.com/sh-khashimov/SwiftFortuneWheel/master/Images/screenshots/3.png', 'https://raw.githubusercontent.com/sh-khashimov/SwiftFortuneWheel/master/Images/screenshots/4.png', 'https://raw.githubusercontent.com/sh-khashimov/SwiftFortuneWheel/master/Images/screenshots/5.png', 'https://raw.githubusercontent.com/sh-khashimov/SwiftFortuneWheel/master/Images/screenshots/6.png', 'https://raw.githubusercontent.com/sh-khashimov/SwiftFortuneWheel/master/Images/screenshots/7.png'
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Sherzod Khashimov" => "sh.khashimov@gmail.com" }
  s.social_media_url   = ""
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.11"
  s.tvos.deployment_target = "9.0"
  s.swift_versions = "5.0"
  s.source       = { :git => "https://github.com/sh-khashimov/SwiftFortuneWheel.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
  s.ios.framework  = 'UIKit'
  s.osx.framework  = 'AppKit'
end
