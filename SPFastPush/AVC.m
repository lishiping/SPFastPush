//
//  OtherVC.m
//  SPPushVC
//
//  Created by uxin-lishiping on 16/12/30.
//  Copyright © 2016年 lishiping. All rights reserved.
//

#import "AVC.h"
#import "SPFastPush.h"
//#import "BVC.h"

@interface AVC ()

@end

@implementation AVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    NSLog(@"标题%@",_titleStr);
    self.title = _titleStr;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 200, 50);
    [button setTitle:@"pushnext" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *backLastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backLastButton.frame = CGRectMake(100, 200, 200, 50);
    [backLastButton setTitle:@"popToLast" forState:UIControlStateNormal];
    [backLastButton addTarget:self action:@selector(popLast) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backLastButton];
    
    UIButton *backRootButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backRootButton.frame = CGRectMake(100, 300, 200, 50);
    [backRootButton setTitle:@"popToRoot" forState:UIControlStateNormal];
    [backRootButton addTarget:self action:@selector(popRoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backRootButton];
    
}

-(void)push
{
    SP_PUSH_VC(@"BVC", @{@"titleName":@"标题是BVC"});
}

-(void)popLast
{
    SP_POP_TO_LAST_VC;
}

-(void)popRoot
{
    SP_POP_TO_ROOT_VC;
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
