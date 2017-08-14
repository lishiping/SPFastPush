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

}


-(void)dismissVC
{
    SP_DISMISS_VC;
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
