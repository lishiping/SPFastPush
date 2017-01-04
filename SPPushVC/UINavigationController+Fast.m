//
//  UINavigationController+Fast.m
//  SPPushVC
//
//  Created by uxin-lishiping on 17/1/3.
//  Copyright © 2017年 lishiping. All rights reserved.
//

#import "UINavigationController+Fast.h"
#import <objc/runtime.h>
#define ASSERT(x)               assert((x))

#define LOG(fmt, ...)           {NSLog((@"%s (line %d) " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);}

// swizzing method for class
#define swizzing_sel_class(_cls_, _sel_1, _sel_2) {\
Method method1 = class_getClassMethod(_cls_, _sel_1);\
Method method2 = class_getClassMethod(_cls_, _sel_2);\
ASSERT(method1 != NULL);\
ASSERT(method2 != NULL);\
LOG(@"swizzing [%@], +%@(0x%08lx) ==> +%@(0x%08lx), ", NSStringFromClass(_cls_), NSStringFromSelector(_sel_1), (long)method1, NSStringFromSelector(_sel_2), (long)method2);\
if (method1 && method2) {\
method_exchangeImplementations(method1, method2);\
}\
}

// swizzing method for instance
#define swizzing_sel_instance(_cls_, _sel_1, _sel_2) {\
Method method1 = class_getInstanceMethod(_cls_, _sel_1);\
Method method2 = class_getInstanceMethod(_cls_, _sel_2);\
ASSERT(method1 != NULL);\
ASSERT(method2 != NULL);\
LOG(@"swizzing (%@), -%@(0x%08lx) ==> -%@(0x%08lx), ", NSStringFromClass(_cls_), NSStringFromSelector(_sel_1), (long)method1, NSStringFromSelector(_sel_2), (long)method2);\
if (method1 && method2) {\
method_exchangeImplementations(method1, method2);\
}\
}


@implementation UINavigationController (Fast)

@dynamic topVC;
static const char *gs_topVC_key = nil;

-(void)setTopVC:(UIViewController *)topVC
{
    objc_setAssociatedObject(self, &gs_topVC_key, topVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIViewController*)topVC
{
  UIViewController *ret =  objc_getAssociatedObject(self, gs_topVC_key);
    return ret;
}

+ (void)initialize;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzing_sel_instance(self, @selector(pushViewController:animated:), @selector(lo_pushViewController:animated:));
        swizzing_sel_instance(self, @selector(popViewControllerAnimated:), @selector(lo_popViewControllerAnimated:));
        swizzing_sel_instance(self, @selector(popToViewController:animated:), @selector(lo_popToViewController:animated:));
        swizzing_sel_instance(self, @selector(popToRootViewControllerAnimated:), @selector(lo_popToRootViewControllerAnimated:));
        swizzing_sel_instance(self, @selector(setViewControllers:), @selector(lo_setViewControllers:));
        swizzing_sel_instance(self, @selector(setViewControllers:animated:), @selector(lo_setViewControllers:animated:));
    });
}

- (void)lo_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
    [self lo_pushViewController:viewController animated:animated];
}
- (nullable UIViewController *)lo_popViewControllerAnimated:(BOOL)animated;
{
    return ([self lo_popViewControllerAnimated:animated]);
}
- (nullable NSArray<__kindof UIViewController *> *)lo_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
    return ([self lo_popToViewController:viewController animated:animated]);
}
- (nullable NSArray<__kindof UIViewController *> *)lo_popToRootViewControllerAnimated:(BOOL)animated;
{
    return ([self lo_popToRootViewControllerAnimated:animated]);
}
- (void)lo_setViewControllers:(NSArray<UIViewController *> *)viewControllers;
{
    [self lo_setViewControllers:viewControllers];
}
- (void)lo_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;
{
    [self lo_setViewControllers:viewControllers animated:animated];
}


//- (UIViewController *)prevViewController;
//{
//    UIViewController *ret = nil;
//    UIViewController *vc = self;
//    while (vc) {
//        if (vc.navigationController) {
//            NSArray *list = vc.navigationController.viewControllers;
//            if (![list containsObject:vc]) {
//                return nil;
//            }
//            // 获取vc在navigationController队列中的位置
//            if (list.firstObject != vc) {
//                long index = [list indexOfObject:vc];
//                ret = [list objectAtIndex:index-1]; // end
//                break;
//            } else {
//                vc = vc.navigationController;
//            }
//        } else if (vc.tabBarController) {
//            vc = vc.tabBarController;
//        } else {
//            ret = [vc presentingViewController];    // end
//            break;
//        }
//    }
//    
//    return (isKindOf(ret, UIViewController) ? ret : nil);
//}


@end
