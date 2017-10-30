
Pod::Spec.new do |s|

  s.name         = "MTPopup"
  s.version      = "1.1.0"
  s.summary      = "You will like it"
  s.homepage     = "https://github.com/huangboju/MTPopup"
  s.license      = "MIT"
  s.author       = { "huangboju" => "xiao-ju@foxmail.com" }
  s.platform     = :ios,'8.0'
  s.source       = { :git => "https://github.com/huangboju/MTPopup.git", :tag => "#{s.version}" }
  s.source_files  = "Classes/**/*.{h,m,swift}"
  s.framework  = "UIKit"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
