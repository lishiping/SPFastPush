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
    UIViewController  *vc = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    if (!vc) {
        
        NSArray *arr = [[UIApplication sharedApplication] windows];
        
        if (arr && arr.count) {
            UIWindow *window = [arr objectAtIndex:0];
            if (window.rootViewController) {
                vc = window.rootViewController;
            }
        }
    }
    
    SP_ASSERT(vc);
    
    return (vc);
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


@end


