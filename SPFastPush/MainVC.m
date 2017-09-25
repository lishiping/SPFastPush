//
//  ViewController.m
//  SPPushVC
//
//  Created by uxin-lishiping on 16/12/29.
//  Copyright © 2016年 lishiping. All rights reserved.
//

#import "MainVC.h"
//#import "AVC.h"
#import "SPFastPush.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *pushNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushNextButton.frame = CGRectMake(100, 100, 200, 50);
    [pushNextButton setTitle:@"pushnext" forState:UIControlStateNormal];
    [pushNextButton addTarget:self action:@selector(pushNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushNextButton];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(100, 200, 200, 50);
    [backButton setTitle:@"presentVC" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(presentVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}

-(void)pushNext
{
  SP_PUSH_VC_BY_CLASSNAME(@"AVC", @{@"titleStr":@"标题AVC"});
}

-(void)presentVC
{
    SP_PRESENT_VC(@"CVC", @{@"titleStr":@"标题CVC"});
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
