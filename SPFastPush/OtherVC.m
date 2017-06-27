//
//  OtherVC.m
//  SPPushVC
//
//  Created by uxin-lishiping on 16/12/30.
//  Copyright © 2016年 lishiping. All rights reserved.
//

#import "OtherVC.h"
#import "SPFastPush.h"
#import "ThirdVC.h"

@interface OtherVC ()

@end

@implementation OtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    NSLog(@"标题%@",_titleStr);
    self.title = _titleStr;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 200, 50);
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *testbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    testbutton.frame = CGRectMake(100, 200, 200, 50);
    [testbutton setTitle:@"textBlock" forState:UIControlStateNormal];
    [testbutton addTarget:self action:@selector(testButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testbutton];
}

-(void)goBack
{
    NSLog(@"点击");
    
    SP_PUSH_VC(@"ThirdVC", @{@"titleName":@"第三个VC"});

//    SP_DISMISS_VC;

}

-(void)testButtonClick:(id)sender
{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
