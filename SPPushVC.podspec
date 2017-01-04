
Pod::Spec.new do |s|

  s.name         = "SPFastPush"
  s.version      = "0.0.1"
  s.summary      = "Use Macro Fast NavigationController push next VC，and Fast Pop anther VC.使用宏帮助导航控制器快速push下一个Viewcontroller,也可以快速返回上一层VC或者指定的VC"


  s.homepage     = "https://github.com/lishiping/SPFastPush.git"
  s.license      = "LICENSE"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "lishiping" => "83118274@qq.com" }

  s.ios.deployment_target = "6.0"

  s.source       = { :git => "https://github.com/lishiping/SPFastPush.git", :tag => "0.0.1" }

   s.source_files  = 'SPPushVC/SPFastPush/*.{h,m,mm,cpp,c}', 'SPPushVC/SPFastPush/*/*.{h,m,mm,cpp,c}'
   s.public_header_files = 'SPPushVC/SPFastPush/*.h', 'SPPushVC/SPFastPush/*/*.h'

  s.framework  = "UIKit"
  s.requires_arc = true

 # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include" }

end
