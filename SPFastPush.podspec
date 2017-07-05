
Pod::Spec.new do |s|

  s.name         = "SPFastPush"
  s.version      = "0.0.16"
  s.summary      = "Use Macro push VC,KVC assign parameter,Pop a VC,Present a VC,Dismiss VC.使用宏push VC,KVC赋值参数,返回指定VC,弹出VC,收回VC"


  s.homepage     = "https://github.com/lishiping/SPFastPush.git"
  s.license      = "LICENSE"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "lishiping" => "83118274@qq.com" }

  s.ios.deployment_target = "6.0"

  s.source       = { :git => "https://github.com/lishiping/SPFastPush.git", :tag => s.version }

   s.source_files  = 'SPFastPush/SPFastPush/*.{h,m,mm,cpp,c}', 'SPFastPush/SPFastPush/*/*.{h,m,mm,cpp,c}'
   s.public_header_files = 'SPFastPush/SPFastPush/*.h', 'SPFastPush/SPFastPush/*/*.h'

  s.framework  = "UIKit"
  s.requires_arc = true

 # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include" }

end
