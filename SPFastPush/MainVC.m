//
//  ViewController.m
//  SPPushVC
//
//  Created by uxin-lishiping on 16/12/29.
//  Copyright © 2016年 lishiping. All rights reserved.
//

#import "MainVC.h"
#import "SPFastPush.h"
#import "CVC.h"

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
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
//        [self pushNext];
//    }];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(100, 200, 200, 50);
    [backButton setTitle:@"presentVC" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(presentVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIButton *alertButton = [UIButton buttonWithType:UIButtonTypeCustom];
    alertButton.frame = CGRectMake(100, 300, 200, 50);
    [alertButton setTitle:@"showAlert" forState:UIControlStateNormal];
    [alertButton addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertButton];
    
}

-(void)pushNext
{
    SP_PUSH_VC_BY_CLASSNAME(@"AVC", @{@"titleStr":@"标题AVC"})
}

-(void)presentVC
{
    UIViewController *cvc = SP_CREATE_VC_BY_CLASSNAME(@"CVC", @{@"titleStr":@"标题CVC"})
    SP_PRESENT_VC(cvc)
}

-(void)showAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
