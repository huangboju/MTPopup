
Pod::Spec.new do |s|

  s.name         = "SwiftySTPopup"
  s.version      = "1.0.0"
  s.summary      = "You will like it"
  s.homepage     = "https://github.com/huangboju/SwiftySTPopup"
  s.license      = "MIT"
  s.author       = { "huangboju" => "529940945@qq.com" }
  s.platform     = :ios,'8.0'
  s.source       = { :git => "https://github.com/huangboju/SwiftySTPopup.git", :tag => "#{s.version}" }
  s.source_files  = "STPopup/Classes/**/*.swift"
  s.framework  = "UIKit"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end
