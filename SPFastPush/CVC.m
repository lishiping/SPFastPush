//
//  CVC.m
//  SPFastPush
//
//  Created by uxin-lishiping on 2017/8/14.
//  Copyright © 2017年 lishiping. All rights reserved.
//

#import "CVC.h"
#import "SPFastPush.h"

@interface CVC ()

@end

@implementation CVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _titleStr;
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(100, 200, 200, 50);
    [backButton setTitle:@"dismissVC" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    UIButton *openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    openButton.frame = CGRectMake(100, 300, 200, 50);
    [openButton setTitle:@"appOpenURL" forState:UIControlStateNormal];
    [openButton addTarget:self action:@selector(appOPenURL) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openButton];

}


-(void)dismissVC
{
    SP_DISMISS_VC
}

-(void)appOPenURL
{
    
//        SP_APP_OPEN_SYSTEM_SETTING_LOCATION
    
    SP_APP_OPEN_URL([NSURL URLWithString:@"https://www.baidu.com/"])

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
