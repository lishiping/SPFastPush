
Pod::Spec.new do |s|

  s.name         = "SPFastPush"
  s.version      = "0.0.9"
  s.summary      = "Use Macro Fast push next VC,use KVC assign parameter,Fast Pop anther VC.使用宏帮助导航控制器快速push下一个VC,利用KVC传入参数,也可快速返回导航栈内指定VC"


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
