# SPFastPush
navigationcontroler fast push VC,fast pop To VC

#pod 'SPFastPush',                   # 加入SPFastPush

#本公开库非常实用，Use Macro NavigationController push next VC，use KVC assign parameter，return current VC Object，and Fast Pop anther VC.

#使用宏帮助导航控制器快速push下一个VC,利用KVC传入参数,也可以快速返回导航栈内指定的VC

#使用宏定义快速push一个VC，原理是遍历当前控制器的导航栈，使用导航控制器push方法，dict字典里面可以传参数，实现原理是KVC动态赋值，并返回push产生的VC对象
