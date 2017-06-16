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

#import <UIKit/UIKit.h>

/**
 Using the macro definition quickly push a VC, traverse the navigation stack find current controller, use the push method of navigation controller, dictionaries can pass parameters, implementation principle is KVC dynamic assignment, and return to push the VC object
 
 使用宏定义快速push一个VC，原理是遍历当前控制器的导航栈，使用导航控制器push方法，dict字典里面可以传参数，实现原理是KVC动态赋值，并返回push产生的VC对象
 
 例如：//SP_PUSH_VC(@"OtherVC", @{@"titleStr":@"other"});

 @param className VC类名
 @param dict      VC所需的参数
 
 @return 返回VC对象
 */
#define SP_PUSH_VC(className, dict)    [SPFastPush pushVCWithClassName:className params:(dict)]


/**
 return last VC
 返回上一个VC
 */
#define SP_POP_TO_LAST_VC    [SPFastPush popToLastVC]


/**
 Navigationcontroler pop to the index of (navigationcontroler.viewcontrolers)
 
 导航控制器返回到指定VC对象的方法,通过索引位置找到导航栈内的VC对象并pop（无动画）
 
 @param index 导航栈VC元素索引
 */
#define SP_POP_TO_VC_AT_INDEX(index)    [SPFastPush popToVCAtIndex:(index) animated:NO]

/**
 导航控制器返回到指定VC对象的方法,通过索引位置找到导航栈内的VC对象并pop（有动画）
 @param index 导航栈VC元素索引
 */
#define SP_POP_TO_VC_AT_INDEX_ANIMATION(index)    [SPFastPush popToVCAtIndex:(index) animated:YES]


/**
 Navigationcontroler pop to VC,find VC object by ClassName in navigationcontroler.viewcontrolers.
 
 导航控制器返回到指定VC对象的方法,通过VC类名找到导航栈内的VC对象并pop，如果一个导航栈里面有多个相同类的VC对象在里面则返回离根部最近的那个VC（导航栈里有相同类的实例对象通常不符合逻辑）
 
 @param className 类名
 */
#define SP_POP_TO_VC_BY_CLASSNAME(className)    [SPFastPush popToVCWithClassName:(className) animated:NO]

/**
 Navigationcontroler pop to VC,find VC object by ClassName in navigationcontroler.viewcontrolers.(with animation)
 
 导航控制器返回到指定VC对象的方法,通过VC类名找到导航栈内的VC对象并pop，如果一个导航栈里面有多个相同类的VC对象在里面则返回离根部最近的那个VC（导航栈里有相同类的实例对象通常不符合逻辑）
 
 @param className 类名
 */
#define SP_POP_TO_VC_BY_CLASSNAME_ANIMATION(className)    [SPFastPush popToVCWithClassName:(className) animated:YES]



@interface SPFastPush : NSObject

/**
 创建VC并push到VC
 
 @param vcClassName 要创建VC的类名称
 @param params    传给VC的参数
 
 @return VC对象
 */
+ (UIViewController *)pushVCWithClassName:(NSString *)vcClassName params:(NSDictionary *)params;

/**
 返回上一个VC
 */
+ (void)popToLastVC;

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
Get the current navigation controller by  traversing
 遍历获得当前VC的导航控制器

 @return 导航控制器对象
 */
+(UINavigationController *)getCurrentNavC;


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


@end


