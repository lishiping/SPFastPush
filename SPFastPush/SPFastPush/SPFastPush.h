//
//  SPFastPush.h
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

#import <UIKit/UIKit.h>


/*********************push pop************************/

/**
 Using the macro definition quickly push a VC, traverse the navigation stack find current controller, use the push method of navigation controller, dictionaries can pass parameters, implementation principle is KVC dynamic assignment, and return to push the VC object (default animation)
 
 使用宏定义快速push一个VC，原理是遍历当前控制器的导航栈，使用导航控制器push方法，dict字典里面可以传参数，实现原理是KVC动态赋值，并返回push产生的VC对象（默认有动画）
 
 例如：//SP_PUSH_VC(@"OtherVC", @{@"titleStr":@"other"});

 @param className VC类名
 @param dict      VC所需的参数
 @return 返回VC对象
 */
#define SP_PUSH_VC_BY_CLASSNAME(className, dict)               [SPFastPush pushVCWithClassName:className params:(dict) animated:YES];

#define SP_PUSH_VC_BY_CLASSNAME_NO_ANIMATED(className, dict)   [SPFastPush pushVCWithClassName:className params:(dict) animated:NO];


/**
 Using the macro definition quickly push a VC, traverse the navigation stack find current controller, use the push method of navigation controller (default animation)
 
 使用宏定义快速push一个VC，原理是遍历当前控制器的导航栈，使用导航控制器push方法（默认有动画）
 
 例如：//OtherVC *vc = [[Other alloc] init];  SP_PUSH_VC(vc);
 
 @param vc VC对象
 */

#define SP_PUSH_VC(vc)               [SPFastPush pushVC:vc animated:YES];

#define SP_PUSH_VC_NO_ANIMATED(vc, dict)   [SPFastPush pushVC:vc animated:NO];


/**
 return last VC(default animation)
 返回上一个VC（默认有动画）
 */
#define SP_POP_TO_LAST_VC               [SPFastPush popToLastVCWithAnimated:YES];

#define SP_POP_TO_LAST_VC_NO_ANIMATED   [SPFastPush popToLastVCWithAnimated:NO];


/**
 pop to root viewcontroller(default no animation)
 返回到导航栈根视图控制器（默认无动画）
 */
#define SP_POP_TO_ROOT_VC            [SPFastPush popToRootVCWithAnimated:NO];

#define SP_POP_TO_ROOT_VC_ANIMATED   [SPFastPush popToRootVCWithAnimated:YES];


/**
 Navigationcontroler pop to the index of (navigationcontroler.viewcontrolers)
 
 导航控制器返回到指定VC对象的方法,通过索引位置找到导航栈内的VC对象并pop（默认无动画）
 
 @param index 导航栈VC元素索引
 */
#define SP_POP_TO_VC_AT_INDEX(index)             [SPFastPush popToVCAtIndex:(index) animated:NO];

#define SP_POP_TO_VC_AT_INDEX_ANIMATION(index)   [SPFastPush popToVCAtIndex:(index) animated:YES];


/**
 Navigationcontroler pop to VC,find VC object by ClassName in navigationcontroler.viewcontrolers.
 
 导航控制器返回到指定VC对象的方法,通过VC类名找到导航栈内的VC对象并pop，如果一个导航栈里面有多个相同类的VC对象在里面则返回离根部最近的那个VC（导航栈里有相同类的实例对象通常不符合逻辑）（默认无动画）
 
 @param className 类名
 */
#define SP_POP_TO_VC_BY_CLASSNAME(className)             [SPFastPush popToVCWithClassName:(className) animated:NO];

#define SP_POP_TO_VC_BY_CLASSNAME_ANIMATION(className)   [SPFastPush popToVCWithClassName:(className) animated:YES];



/*********************present dismiss************************/

/**
 Using the macro definition quickly present a VC, get current controller by traversing, dictionaries can pass parameters, implementation principle is KVC dynamic assignment, and return the VC object
 
 使用宏定义快速present一个VC，原理是遍历得到当前控制器，present 一个新的VC，dict字典里面可以传参数，实现原理是KVC动态赋值（默认有动画）
 
 例如：//SP_PUSH_VC(@"OtherVC", @{@"titleStr":@"other"});
 
 @param className VC类名
 @param dict      VC所需的参数
 
 @return 返回VC对象
 */
#define SP_PRESENT_VC_BY_CLASSNAME(className, dict)               [SPFastPush presentVC:className params:(dict) animated:YES];

#define SP_PRESENT_VC_BY_CLASSNAME_NO_ANIMATED(className, dict)   [SPFastPush presentVC:className params:(dict) animated:NO];


#define SP_PRESENT_VC(vc)               [SPFastPush presentVC:vc animated:YES];

#define SP_PRESENT_VC_NO_ANIMATED(vc)   [SPFastPush presentVC:vc animated:NO];

/**
 dismissViewController Animated
 收回弹出的VC（默认有动画）

 @return vc object
 */
#define SP_DISMISS_VC               [SPFastPush dismissVCAnimated:YES];

#define SP_DISMISS_VC_NO_ANIMATED   [SPFastPush dismissVCAnimated:NO];


/*********************Create VC Object************************/

/**
 创建一个VC，并使用KVC赋值
 
 @param className vc类名
 @param params 赋值参数
 @return 返回VC对象
 */
#define SP_CREATE_VC_BY_CLASSNAME(className, dict)               [SPFastPush createVC:className withParams:(dict)];


/*********************get Navc topVC rootVC************************/

/**
 Get the current navigation controller by  traversing
 遍历获得当前VC的导航控制器
 
 @return 导航控制器对象
 */
#define SP_GET_CURRENT_NAVC   [SPFastPush getCurrentNavC];


/**
 Get the current display controller object
 获得当前显示的控制器对象
 
 @return vc object
 */
#define SP_GET_TOP_VC   [SPFastPush topVC];


/**
 Get rootViewController
 获取APP根视图控制器
 
 @return rootViewController
 */
#define SP_GET_ROOT_VC   [SPFastPush rootVC];

/**
 获取根部的tabBarController
 
 @return tabBarController
 */
#define SP_GET_CURRENT_TABVC   [SPFastPush getCurrentTabVC];

/**
 设置根部tabBarController的selectIndex
 
 @param selectIndex 位置
 @return 设置是否成功
 */
#define SP_CURRENT_TABVC_SET_SELECTINDEX(selectIndex)  [SPFastPush currentTabVCSetToSelectIndex:(selectIndex)];



@interface SPFastPush : NSObject

/**
 创建VC并push到VC
 
 @param vcClassName 要创建VC的类名称
 @param params    传给VC的参数
 @param animated  是否动画
 @return VC对象
 */
+ (UIViewController *)pushVCWithClassName:(NSString *)vcClassName params:(NSDictionary *)params animated:(BOOL)animated;

/**
 导航控制器push一个vc对象
 
 @param vc 实例化的vc对象
 @param animated  是否动画
 */
+ (void)pushVC:(UIViewController *)vc animated:(BOOL)animated;

/**
 返回上一个VC
 */
+ (void)popToLastVCWithAnimated:(BOOL)animated;

/**
 返回到导航器根视图控制器

 @param animated 是否动画
 */
+ (void)popToRootVCWithAnimated:(BOOL)animated;

/**
 导航栈内返回指定位置的方法

 @param index    导航栈元素索引
 @param animated 有无动画
 */
+ (void)popToVCAtIndex:(NSInteger)index animated:(BOOL)animated;

/**
 导航栈返回到指定输入的类名（带动画），如果一个导航栈里面有多个相同类的VC对象在里面则返回离根部最近的那个VC（导航栈里有相同类的实例对象通常不符合逻辑）

 @param className 类名
 @param animated  是否需要动画
 */
+(void)popToVCWithClassName:(NSString*)className animated:(BOOL)animated;

/**
 创建一个VC，并使用KVC赋值，然后弹出

 @param vcClassName vc类名
 @param params 赋值参数
 @param animated 是否动画
 @return 返回弹出的VC对象
 */
+(UIViewController *)presentVC:(NSString *)vcClassName params:(NSDictionary *)params animated:(BOOL)animated;

/**
 弹出一个VC对象
 
 @param vc ViewController对象
 @param animated 是否动画
 */
+(void)presentVC:(UIViewController *)vc animated:(BOOL)animated;


/**
 收回弹出的VC
 */
+ (void)dismissVCAnimated:(BOOL)animated;


/**
 创建一个VC，并使用KVC赋值
 
 @param className vc类名
 @param params 赋值参数
 @return 返回VC对象
 */
+ (UIViewController *)createVC:(NSString *)className withParams:(NSDictionary *)params;

/**
Get the current navigation controller by  traversing
 遍历获得当前VC的导航控制器

 @return 导航控制器对象
 */
+(UINavigationController *)getCurrentNavC;

/**
 Get the current PresentingViewController by  traversing
 遍历获得弹出当前VC的父VC
 
 @return 导航控制器对象
 */
+(UIViewController *)getPresentingVC;


/**
 Get the current display controller object
 获得当前显示的控制器对象

 @return vc object
 */
+ (UIViewController *)topVC;


/**
 Get rootViewController
 获取APP根视图控制器

 @return rootViewController
 */
+ (UIViewController *)rootVC;


/**
 获取根部的tabBarController

 @return tabBarController
 */
+ (UITabBarController *)getCurrentTabVC;


/**
 设置根部tabBarController的selectIndex

 @param selectIndex 位置
 @return 设置是否成功
 */
+ (BOOL)currentTabVCSetToSelectIndex:(NSUInteger)selectIndex;

@end


