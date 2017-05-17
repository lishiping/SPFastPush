//
//  SPFastPush.m
//  e-mail:83118274@qq.com
//
//  Created by lishping on 16/11/11.
//  Copyright (c) 2016年 lishiping. All rights reserved.
//
//If you feel the WebView open source is of great help to you, please give the author some praise, recognition you give great encouragement, the author also hope you give the author other open source libraries some praise, the author will release better open source library for you again
//如果您感觉本开源WebView对您很有帮助，请给作者点个赞，您的认可给作者极大的鼓励，也希望您给作者其他的开源库点个赞，作者还会再发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData

#import "SPFastPush.h"

#define SPisKindOf(x, cls)                [(x) isKindOfClass:[cls class]]         // 判断实例类型(含父类)

#if DEBUG

#define SPDLOG(fmt, ...)           {NSLog((@"%s (line %d) " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);}

#else

#define SPDLOG(fmt, ...)

#endif



@interface SPFastPush ()
{
}

@end

@implementation SPFastPush


#pragma mark - Navigation

+ (void)pushVC:(UIViewController *)vc;
{
    if (!SPisKindOf(vc, UIViewController))
    {
        return;
    }
    else
    {
        //find NavigationController
        UINavigationController *navc = [[self class]topVC].navigationController;
        
        if (!navc) {
            SPDLOG(@"no find NavigationController,can not push!!!")
            return;
        }
        
        if (navc.viewControllers.count) {
            vc.hidesBottomBarWhenPushed = YES;
        }
        
        [navc pushViewController:vc animated:YES];
    }
}

+ (UIViewController *)topVC;
{
    UIViewController *ret = nil;
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (vc) {
        ret = vc;
        if (SPisKindOf(vc, UINavigationController)) {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if (SPisKindOf(vc, UITabBarController)) {
            vc = [(UITabBarController *)vc selectedViewController];
        } else {
            vc = [vc presentedViewController];
        }
    }
    
    return (SPisKindOf(ret, UIViewController) ? ret : nil);
}

//- (UINavigationController *)getCurrentNavigationController;
//{
//    UINavigationController *ret = (UINavigationController *)[[self class] rootVC];
//    if (isKindOf(ret, UINavigationController)) {
//        return ret;
//    }
//    else if (isKindOf(ret, UITabBarController)) {
//        ret = ((UITabBarController *)ret).selectedViewController;
//    }
//    return (isKindOf(ret, UINavigationController) ? ret : nil);
//}

#pragma mark - kvc

+(UIViewController *)pushVCWithClassName:(NSString *)vcClassName params:(NSDictionary *)params
{
    //创建当前类并加入属性
    UIViewController *ret = [[self  class] createVC:vcClassName withParams:params];
    
    if (ret) {
        [[self class] pushVC:ret];
    }
    
    return (ret);
}
+ (UIViewController *)createVC:(NSString *)className withParams:(NSDictionary *)params;
{
    if (!SPisKindOf(className, NSString)||className.length==0) {
        return nil;
    }
    
    UIViewController *ret = nil;
    NSString *name = [className stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    Class cls = NSClassFromString(name);
    if (cls && [cls isSubclassOfClass:[UIViewController class]]) {
        
        // create viewController
        UIViewController *vc = [[cls alloc] init];
        
        // kvc set params;
        vc = [[self class] object:vc kvc_setParams:params];
        
        ret = vc;
    } else {
        SPDLOG(@"%@ class not Find!!!!!-----", className);
    }
    return (ret);
}

+ (id)object:(id)object kvc_setParams:(NSDictionary *)params;
{
    if (!SPisKindOf(params, NSDictionary) || (params.count < 1))
        return object;
    @try {
        [object setValuesForKeysWithDictionary:params];
    } @catch (NSException *exception) {
        SPDLOG(@"KVC Set Value For Key error:%@", exception);
    } @finally {
    }
    return object;
}

+ (void)popToLastVC
{
    UIViewController *vc = [[self class]topVC];
    if (vc.navigationController.viewControllers.count>1)
    {
        [vc.navigationController popViewControllerAnimated:YES];
    }
}

+ (void)popToVCAtIndex:(NSInteger)index animated:(BOOL)animated
{
    UIViewController *vc = [[self class]topVC];
    //导航栈内一定要超过1个vc，否则不能pop
    if (index>=0&&vc.navigationController.viewControllers.count>1&&vc.navigationController.viewControllers.count>index)
    {
        //从导航栈顶跳到栈顶不成立，所以返回
        if (vc.navigationController.viewControllers.count-1==index) {
            return;
        }
        
        UIViewController *obj = [vc.navigationController.viewControllers objectAtIndex:index];
        
        [vc.navigationController popToViewController:obj animated:animated];
    }
}

+ (void)popToVCWithClassName:(NSString *)className animated:(BOOL)animated
{
    if (!SPisKindOf(className, NSString)||className.length==0) {
        return;
    }
    NSString *name = [className stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    Class cls = NSClassFromString(name);
    
    if (!cls || ![cls isSubclassOfClass:[UIViewController class]])
    {
        return;
    }
    
    UIViewController *vc = [[self class]topVC];
    //导航栈内一定要超过1个vc，否则不能pop
    if (vc.navigationController.viewControllers.count>1)
    {
        NSArray *vcArr = vc.navigationController.viewControllers;
        
        for (UIViewController *vcobj in vcArr) {
            if (SPisKindOf(vcobj, cls)) {
                
                [vc.navigationController popToViewController:vcobj animated:animated];
            }
        }
    }
}


@end


