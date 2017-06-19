//
//  ViewController.m
//  SPPushVC
//
//  Created by uxin-lishiping on 16/12/29.
//  Copyright © 2016年 lishiping. All rights reserved.
//

#import "MainVC.h"
#import "OtherVC.h"
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
    
    UIButton *pushSelfButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushSelfButton.frame = CGRectMake(100, 200, 200, 50);
    [pushSelfButton setTitle:@"pushself" forState:UIControlStateNormal];
    [pushSelfButton addTarget:self action:@selector(pushSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushSelfButton];
}

-(void)pushNext
{
  SP_PUSH_VC(@"OtherVC", @{@"titleStr":@"other"});
}

-(void)pushSelf
{
    SP_PUSH_VC(@"MainVC", nil);
    
//    [SPFastPush presentViewController:@"OtherVC" params:nil animated:NO];
    
//    SP_PRESENT_VC(@"OtherVC", nil);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
