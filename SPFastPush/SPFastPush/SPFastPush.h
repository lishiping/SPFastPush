//
//  SPFastPush.h
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 16/11/11.
//  Copyright (c) 2016年 lishiping. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 使用宏定义快速push一个VC，dict字典里面可以传送复杂数据，并返回新生成的VC，例如：
 //SPFastPush_OpenVC(@"OtherVC", @{@"titleStr":@"other"});
 实现原理是KVC动态赋值
 @param className VC类名
 @param dict      VC所需的参数
 
 @return 返回VC对象
 */
#define SPFastPush_OpenVC(className, dict)    [SPFastPush openVC:className withParams:(dict)]

/**
 返回上一个VC
 */
#define SPFastPush_PopToLastVC    [SPFastPush goBack]

/**
 Navigationcontroler popto the index of viewcontrolers (navigationcontroler.viewcontrolers)
 导航栈内返回指定位置的方法（无动画）
 @param index 导航栈元素索引
 */
#define SPFastPush_PopToVCAtIndex(index)    [SPFastPush popToVCAtIndex:(index) animated:NO]

/**
 导航栈内返回指定位置的方法（有动画）
 @param index 导航栈元素索引
 */
#define SPFastPush_PopToVCAtIndexWithAnimation(index)    [SPFastPush popToVCAtIndex:(index) animated:YES]

/**
 Navigationcontroler back to input of ClassName
 导航栈返回到指定输入的类名（不带动画），如果一个导航栈里面有多个相同类的VC对象在里面则返回离根部最近的那个VC（导航栈里有相同类的实例对象通常不符合逻辑）
 @param className 类名
 */
#define SPFastPush_PopToVCByClassName(className)    [SPFastPush popToVCWithClassName:(className) animated:NO]

/**
 Navigationcontroler back to input of ClassName
 导航栈返回到指定输入的类名（带动画），如果一个导航栈里面有多个相同类的VC对象在里面则返回离根部最近的那个VC（导航栈里有相同类的实例对象通常不符合逻辑）
 @param className 类名
 */
#define SPFastPush_PopToVCByClassNameWithAnimation(className)    [SPFastPush popToVCWithClassName:(className) animated:YES]



@interface SPFastPush : NSObject

/**
 创建VC并push到VC
 
 @param className 要创建VC的类名称
 @param params    传给VC的参数
 
 @return VC对象
 */
+ (UIViewController *)openVC:(NSString *)className withParams:(NSDictionary *)params;

/**
 返回上一个VC
 */
+ (void)goBack;

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

@end


