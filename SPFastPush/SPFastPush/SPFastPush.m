//
//  SPFastPush.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 16/11/11.
//  Copyright (c) 2016年 lishiping. All rights reserved.
//
//If you think this open source library is of great help to you, please open the URL to click the Star,your approbation can encourage me, the author will publish the better open source library for guys again
//如果您认为本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory
//github address//https://github.com/lishiping/SPBaseClass

#import "SPFastPush.h"

#define SP_IS_KIND_OF(obj, cls) [(obj) isKindOfClass:[cls class]]

#define SP_IS_MEMBER_OF(obj, cls) [(obj) isMemberOfClass:[cls class]]

// (is main thread)判断是否主线程
#define SP_IS_MAIN_THREAD                [NSThread isMainThread]

// (run in main thread)使block在主线程中运行
#define SP_RUN_MAIN_THREAD(block)    if (SP_IS_MAIN_THREAD) {(block);} else {dispatch_async(dispatch_get_main_queue(), ^{(block);});}


#if DEBUG

#define SP_LOG(...) NSLog(__VA_ARGS__)

#define SP_ASSERT(obj)               assert((obj))

#define SP_ASSERT_CLASS(obj, cls)  SP_ASSERT((obj) && SP_IS_KIND_OF(obj,cls))//断言实例有值和类型


#else

#define SP_LOG(...)

#define SP_ASSERT(obj)

#define SP_ASSERT_CLASS(obj, cls)

#endif


@interface SPFastPush ()
{
}

@end

@implementation SPFastPush


#pragma mark - push & pop

+(UIViewController *)pushVCWithClassName:(NSString *)vcClassName params:(NSDictionary *)params animated:(BOOL)animated
{
    //创建当前类并加入属性
    UIViewController *ret = [[self class] createVC:vcClassName withParams:params];
    
    SP_ASSERT(ret);
    
    SP_LOG(@"push class is-----%s",object_getClassName(ret));
    
    [[self class] pushVC:ret animated:animated];
    
    return (ret);
}

+ (UIViewController *)createVC:(NSString *)className withParams:(NSDictionary *)params
{
    SP_ASSERT_CLASS(className, NSString);
    
    if (!SP_IS_KIND_OF(className, NSString)||className.length==0) {
        SP_LOG(@"className string error!!!!!-----");
        return nil;
    }
    
    UIViewController *ret = nil;
    NSString *name = [className stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    Class cls = NSClassFromString(name);
    
    if (cls && [cls isSubclassOfClass:[UIViewController class]]) {
        
        // create viewController
        UIViewController *vc = [[cls alloc] init];
        
        // kvc set params;
        ret = [[self class] object:vc kvc_setParams:params];
        
    } else {
        SP_LOG(@"%@ class not Find!!!!!-----", className);
    }
    return (ret);
}

+ (id)object:(id)object kvc_setParams:(NSDictionary *)params;
{
    if (SP_IS_KIND_OF(params, NSDictionary) && (params.count>0))
    {
        @try {
            [object setValuesForKeysWithDictionary:params];
        } @catch (NSException *exception) {
            SP_LOG(@"KVC Set Value For Key error:%@", exception);
        } @finally {
        }
    }
    
    return object;
}

+ (void)pushVC:(UIViewController *)vc animated:(BOOL)animated
{
    SP_ASSERT_CLASS(vc, UIViewController);
    
    if (SP_IS_KIND_OF(vc, UIViewController))
    {
        //find NavigationController
        UINavigationController *navc = [[self class] getCurrentNavC];
        
        if (navc) {
            if (navc.viewControllers.count) {
                vc.hidesBottomBarWhenPushed = YES;
            }
            
            SP_RUN_MAIN_THREAD([navc pushViewController:vc animated:animated]);
            
        }else
        {
            SP_LOG(@"no find NavigationController,can not push!!!");
        }
    }
}

+ (void)popToLastVCWithAnimated:(BOOL)animated
{
    UINavigationController *navc = [[self class] getCurrentNavC];
    if (navc && navc.viewControllers.count>1)
    {
        SP_RUN_MAIN_THREAD([navc popViewControllerAnimated:animated]);
    }
}

+ (void)popToRootVCWithAnimated:(BOOL)animated
{
    UINavigationController *navc = [[self class] getCurrentNavC];
    if (navc && navc.viewControllers.count>1)
    {
        SP_RUN_MAIN_THREAD([navc popToRootViewControllerAnimated:animated]);
    }
}
+ (void)popToVCAtIndex:(NSInteger)index animated:(BOOL)animated
{
    SP_ASSERT(index>=0);
    
    UINavigationController *navc = [[self class] getCurrentNavC];
    //导航栈内一定要超过1个vc，否则不能pop
    if (navc && index>=0 && navc.viewControllers.count>1 && navc.viewControllers.count>index)
    {
        //从导航栈顶跳到栈顶不成立，所以返回
        if (navc.viewControllers.count-1==index) {
            SP_LOG(@"NavigationController.viewcontrollers.cout==1,can not pop!!!");
            return;
        }
        
        UIViewController *obj = [navc.viewControllers objectAtIndex:index];
        
        SP_ASSERT_CLASS(obj, UIViewController);
        
        if (obj) {
            
            SP_LOG(@"pop to class is-----%s",object_getClassName(obj));
            
            SP_RUN_MAIN_THREAD([navc popToViewController:obj animated:animated]);
        }
        else
        {
            SP_LOG(@"not find vc object,can not pop!!!");
        }
    }
    else
    {
        SP_LOG(@"can not pop!!!");
    }
}

+ (void)popToVCWithClassName:(NSString *)className animated:(BOOL)animated
{
    SP_ASSERT_CLASS(className, NSString);
    
    if (!SP_IS_KIND_OF(className, NSString)||className.length==0) {
        SP_LOG(@"className string error!!!!!-----");
        return;
    }
    NSString *name = [className stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    Class cls = NSClassFromString(name);
    
    if (!cls || ![cls isSubclassOfClass:[UIViewController class]])
    {
        SP_LOG(@"%@ class not Find!!!!!-----", className);
        return;
    }
    
    UINavigationController *navc = [[self class] getCurrentNavC];
    
    //导航栈内一定要超过1个vc，否则不能pop
    if (navc && navc.viewControllers.count>1)
    {
        NSArray *vcArr = navc.viewControllers;
        
        for (UIViewController *vcobj in vcArr) {
            
            SP_ASSERT_CLASS(vcobj , UIViewController);
            
            if (SP_IS_MEMBER_OF(vcobj, cls)) {
                
                SP_LOG(@"pop to class is-----%@",className);
                
                SP_RUN_MAIN_THREAD([navc popToViewController:vcobj animated:animated]);
                return;
            }
        }
    }
}

#pragma mark - present & dismiss

+(UIViewController *)presentVC:(NSString *)vcClassName params:(NSDictionary *)params animated:(BOOL)animated
{
    //创建当前类并加入属性
    UIViewController *ret = [[self class] createVC:vcClassName withParams:params];
    
    SP_ASSERT(ret);
    
    SP_LOG(@"present class is-----%s",object_getClassName(ret));
    
    [[self class] presentVC:ret animated:animated];
    
    return  ret;
}

+(void)presentVC:(UIViewController *)vc animated:(BOOL)animated
{
    SP_ASSERT_CLASS(vc, UIViewController);
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        
        UIViewController *topVC = [[self class] topVC];
        
        if (topVC) {
            SP_RUN_MAIN_THREAD([topVC presentViewController:vc animated:animated completion:nil]);
        }
    }
}

+ (void)dismissVCAnimated:(BOOL)animated
{
    UIViewController *vc = [[self class] getPresentingVC];
    if (vc)
    {
        SP_RUN_MAIN_THREAD([vc dismissViewControllerAnimated:animated completion:nil]);
    }
}


#pragma mark - get VC
+(UINavigationController *)getCurrentNavC
{
    UINavigationController *navc = [[self class] topVC].navigationController;
    
    SP_ASSERT_CLASS(navc, UINavigationController);
    
    return (SP_IS_KIND_OF(navc, UINavigationController) ? navc : nil);
}

+(UIViewController *)getPresentingVC
{
    UIViewController *ret = nil;
    UIViewController *topVC = [[self class] topVC];
    if (topVC.presentingViewController) {
        ret = topVC.presentingViewController;
    }
    
    if (!ret) {
        
        if (topVC.navigationController) {
            UIViewController *tempVC  =  topVC.navigationController.presentingViewController;
            
            if (tempVC) {
                ret = tempVC;
            }
        }
    }
    
    SP_ASSERT_CLASS(ret, UIViewController);
    
    return ret;
}

+ (UIViewController *)topVC
{
    UIViewController *ret = nil;
    UIViewController *vc = [[self class] rootVC];
    while (vc) {
        ret = vc;
        if (SP_IS_KIND_OF(ret, UINavigationController))
        {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if (SP_IS_KIND_OF(ret, UITabBarController))
        {
            vc = [(UITabBarController *)vc selectedViewController];
        } else
        {
            vc = [vc presentedViewController];
        }
    }
    
    SP_ASSERT_CLASS(ret, UIViewController);
    
    return (SP_IS_KIND_OF(ret, UIViewController) ? ret : nil);
}

+ (UIViewController *)rootVC
{
    UIViewController  *vc = [[self class] mainWindow].rootViewController;
    
    SP_ASSERT(vc);
    
    return (vc);
}

+ (UIWindow*)mainWindow
{
    UIWindow *window = nil;
    
    UIApplication *app  = [UIApplication sharedApplication];
    
    if ([app.delegate respondsToSelector:@selector(window)]) {
        window = [app.delegate window];
    }
    else if ([app windows].count>0)
    {
        window = [[app windows] objectAtIndex:0];
    }
    
    return window;
}

+ (UITabBarController *)getCurrentTabVC
{
    UITabBarController *tab = (UITabBarController *)[[self class] rootVC];
    
    SP_ASSERT_CLASS(tab, UITabBarController);
    
    return (SP_IS_KIND_OF(tab, UITabBarController) ? tab : nil);
}

+ (BOOL)currentTabVCSetToSelectIndex:(NSUInteger)selectIndex
{
    UITabBarController *tab = [[self class] getCurrentTabVC];
    
    if (tab && tab.viewControllers.count>selectIndex)
    {
        tab.selectedIndex = selectIndex;
        return YES;
    }
    return NO;
}

#pragma mark - APP打开系统URL

+(void)appOpenURLString:(NSString *)urlString option:(NSDictionary*)option completionHandler:(void (^ __nullable)(BOOL success))completion
{
    if ([urlString isKindOfClass:[NSString class]]&&urlString.length>0) {
        [self appOpenURL:[NSURL URLWithString:urlString] option:option completionHandler:completion];
    }
}

+(void)appOpenURL:(NSURL *)url option:(NSDictionary*)option completionHandler:(void (^ __nullable)(BOOL success))completion
{
    if (url)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[UIDevice currentDevice].systemVersion floatValue]>=10.0f)
            {
                [[UIApplication sharedApplication] openURL:url options:option completionHandler:completion];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        });
    }
}

/*
 注意：
 
 1.iOS10及以后prefs前缀不再生效，APP—Prefs前缀可用
 2.iOS10之前两个前缀都可用,但是prefs可以到达详细的页面，例如可以直接到达定位的开关
 3.iOS11及以后prefs前缀不再生效，APP—Prefs前缀跳转只能到系统的设置页，不能到设置里面的具体页面
 
 要跳转的设置界面    URL String
 WIFI    App-Prefs:root=WIFI
 Bluetooth    App-Prefs:root=Bluetooth
 蜂窝移动网络    App-Prefs:root=MOBILE_DATA_SETTINGS_ID
 个人热点    App-Prefs:root=INTERNET_TETHERING
 VPN    App-Prefs:root=VPN
 运营商    App-Prefs:root=Carrier
 通知    App-Prefs:root=NOTIFICATIONS_ID
 定位服务    App-Prefs:root=Privacy&path=LOCATION
 通用    App-Prefs:root=General
 关于本机    App-Prefs:root=General&path=About
 键盘    App-Prefs:root=General&path=Keyboard
 辅助功能    App-Prefs:root=General&path=ACCESSIBILITY
 语言与地区    App-Prefs:root=General&path=INTERNATIONAL
 还原    App-Prefs:root=General&path=Reset
 墙纸    App-Prefs:root=Wallpaper
 Siri    App-Prefs:root=SIRI
 隐私    App-Prefs:root=Privacy
 Safari    App-Prefs:root=SAFARI
 音乐    App-Prefs:root=MUSIC
 照相与照相机    App-Prefs:root=Photos
 FaceTime    App-Prefs:root=FACETIME
 电池电量    App-Prefs:root=BATTERY_USAGE
 存储空间    App-Prefs:root=General&path=STORAGE_ICLOUD_USAGE/DEVICE_STORAGE
 显示与亮度    App-Prefs:root=DISPLAY
 声音设置    App-Prefs:root=Sounds
 App Store    App-Prefs:root=STORE
 iCloud    App-Prefs:root=CASTLE
 语言设置    App-Prefs:root=General&path=INTERNATIONAL
 
 
 蜂窝网络：prefs:root=MOBILE_DATA_SETTINGS_ID
 VPN — prefs:root=General&path=Network/VPN
 Wi-Fi：prefs:root=WIFI
 定位服务：prefs:root=LOCATION_SERVICES
 个人热点：prefs:root=INTERNET_TETHERING
 关于本机：prefs:root=General&path=About
 辅助功能：prefs:root=General&path=ACCESSIBILITY
 飞行模式：prefs:root=AIRPLANE_MODE
 锁定：prefs:root=General&path=AUTOLOCK
 亮度：prefs:root=Brightness
 蓝牙：prefs:root=General&path=Bluetooth
 时间设置：prefs:root=General&path=DATE_AND_TIME
 FaceTime：prefs:root=FACETIME
 设置：prefs:root=General
 键盘设置：prefs:root=General&path=Keyboard
 iCloud：prefs:root=CASTLEiCloud
 备份：prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 语言：prefs:root=General&path=INTERNATIONAL
 定位：prefs:root=LOCATION_SERVICES
 音乐：prefs:root=MUSICMusic
 Equalizer — prefs:root=MUSIC&path=EQMusic
 Volume Limit — prefs:root=MUSIC&path=VolumeLimit
 Network — prefs:root=General&path=Network
 Nike + iPod — prefs:root=NIKE_PLUS_IPOD
 Notes — prefs:root=NOTES
 Notification — prefs:root=NOTIFICATIONS_ID
 Phone — prefs:root=Phone
 Photos — prefs:root=Photos
 Profile —prefs:root=General&path=ManagedConfigurationList
 Reset — prefs:root=General&path=Reset
 Safari — prefs:root=Safari
 Siri — prefs:root=General&path=Assistant
 Sounds — prefs:root=Sounds
 Software Update —prefs:root=General&path=SOFTWARE_UPDATE_LINK
 Store — prefs:root=STORET
 witter — prefs:root=TWITTER
 Usage — prefs:root=General&path=USAGE
 Wallpaper — prefs:root=Wallpaper
 
 */

//打开系统通知
+(void)appOpenSystemSettingNotification
{
    //ios10之前可以直接跳到具体页面
    NSString *urlString = @"prefs:root=NOTIFICATIONS_ID";
    if ([UIDevice currentDevice].systemVersion.floatValue>=10.0f) {
        //ios10之后只能跳到设置页面
        urlString = @"App-Prefs:root=NOTIFICATIONS_ID";
    }
    
    [self appOpenURLString:urlString option:@{} completionHandler:nil];
}

//打开系统定位
+(void)appOpenSystemSettingLocation
{
    //ios10之前可以直接跳到定位的具体页面
    NSString *urlString = @"prefs:root=LOCATION_SERVICES";
    if ([UIDevice currentDevice].systemVersion.floatValue>=10.0f) {
        //ios10之后只能跳到设置页面
        urlString = @"App-Prefs:root=LOCATION_SERVICES";
    }
    
    [self appOpenURLString:urlString option:@{} completionHandler:nil];
}

//打开系统wifi
+(void)appOpenSystemSettingWIFI
{
    //ios10之前可以直接跳到具体页面
    NSString *urlString = @"prefs:root=WIFI";
    if ([UIDevice currentDevice].systemVersion.floatValue>=10.0f) {
        //ios10之后只能跳到设置页面
        urlString = @"App-Prefs:root=WIFI";
    }
    
    [self appOpenURLString:urlString option:@{} completionHandler:nil];
}

//打开系统设置
+(void)appOpenSystemSetting
{
    NSString *urlString = @"prefs:root";
    if ([UIDevice currentDevice].systemVersion.floatValue>=8.0f) {
        urlString = UIApplicationOpenSettingsURLString;
    }
    
    [self appOpenURLString:urlString option:@{} completionHandler:nil];
}


//调取系统拨打电话
+(void)appOpenTelPhone:(NSString *)phoneNumber needAlert:(BOOL)isNeedAlert
{
    if ([phoneNumber isKindOfClass:[NSString class]] && phoneNumber.length > 0)
    {
        NSString *tel = [NSString stringWithFormat:(isNeedAlert ? @"telprompt://%@" : @"tel://%@"), phoneNumber];
        [[self class] appOpenURLString:tel option:nil completionHandler:nil];
    }
}


@end


