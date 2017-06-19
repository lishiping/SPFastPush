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

#import "SPFastPush.h"

#define SP_IS_KIND_OF(obj, cls) [(obj) isKindOfClass:[cls class]]

#if DEBUG

#define SP_LOG(...) NSLog(__VA_ARGS__);

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


#pragma mark - create & kvc

+(UIViewController *)pushVCWithClassName:(NSString *)vcClassName params:(NSDictionary *)params
{
    //创建当前类并加入属性
    UIViewController *ret = [[self  class] createVC:vcClassName withParams:params];
    
    SP_ASSERT(ret);
    
    if (ret) {
        [[self class] pushVC:ret];
    }
    
    return (ret);
}

+ (UIViewController *)createVC:(NSString *)className withParams:(NSDictionary *)params;
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
    if (!SP_IS_KIND_OF(params, NSDictionary) || (params.count < 1))
    {
        return object;
    }
    
    @try {
        [object setValuesForKeysWithDictionary:params];
    } @catch (NSException *exception) {
        SP_LOG(@"KVC Set Value For Key error:%@", exception);
    } @finally {
    }
    return object;
}

#pragma mark - Navigation

+ (void)pushVC:(UIViewController *)vc;
{
    SP_ASSERT_CLASS(vc, UIViewController);

    if (!SP_IS_KIND_OF(vc, UIViewController))
    {
        return;
    }
    else
    {
        //find NavigationController
        UINavigationController *navc = [[self class] getCurrentNavC];
        
        if (!navc) {
            SP_LOG(@"no find NavigationController,can not push!!!")
            return;
        }
        
        if (navc.viewControllers.count) {
            vc.hidesBottomBarWhenPushed = YES;
        }
        
        [navc pushViewController:vc animated:YES];
    }
}

+ (void)popToLastVC
{
    UINavigationController *navc = [[self class] getCurrentNavC];
    if (navc.viewControllers.count>1)
    {
        [navc popViewControllerAnimated:YES];
    }
}

+ (void)popToVCAtIndex:(NSInteger)index animated:(BOOL)animated
{
    UINavigationController *navc = [[self class] getCurrentNavC];
    //导航栈内一定要超过1个vc，否则不能pop
    if (index>=0 && navc.viewControllers.count>1 && navc.viewControllers.count>index)
    {
        //从导航栈顶跳到栈顶不成立，所以返回
        if (navc.viewControllers.count-1==index) {
            return;
        }
        
        UIViewController *obj = [navc.viewControllers objectAtIndex:index];
        
        SP_ASSERT_CLASS(obj, UIViewController);

        if (!navc && obj) {
            [navc popToViewController:obj animated:animated];
        }
        else
        {
            SP_LOG(@"no find NavigationController,can not push!!!")
            return;
        }
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
    if (navc.viewControllers.count>1)
    {
        NSArray *vcArr = navc.viewControllers;
        
        for (UIViewController *vcobj in vcArr) {
            
            SP_ASSERT_CLASS(vcobj , UIViewController);

            if (SP_IS_KIND_OF(vcobj, cls)) {
                
                [navc popToViewController:vcobj animated:animated];
                return;
            }
        }
    }
}

#pragma mark -get VC
+(UINavigationController *)getCurrentNavC
{
    UINavigationController *navc = [[self class] topVC].navigationController;
    
    SP_ASSERT_CLASS(navc, UINavigationController);
    
    return (SP_IS_KIND_OF(navc, UINavigationController) ? navc : nil);
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
    UIViewController  *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
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


@end


