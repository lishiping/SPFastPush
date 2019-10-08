
Pod::Spec.new do |s|

  s.name         = "SPFastPush"
  s.version      = "0.9.0"
  s.summary      = "Use Macro (Push,Pop,Present,Dismiss) VC,KVC assign parameter,App Open URL.一个vc跳转路由,打开系统及第三方scheme的方法"


  s.homepage     = "https://github.com/lishiping/SPFastPush.git"
  s.license      = "LICENSE"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "lishiping" => "83118274@qq.com" }

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/lishiping/SPFastPush.git", :tag => s.version }

   s.source_files  = 'SPFastPush/SPFastPush/*.{h,m,mm,cpp,c}', 'SPFastPush/SPFastPush/*/*.{h,m,mm,cpp,c}'
   s.public_header_files = 'SPFastPush/SPFastPush/*.h', 'SPFastPush/SPFastPush/*/*.h'

  s.framework  = "UIKit"
  s.requires_arc = true

 # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include" }

end
