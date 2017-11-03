//
//  JJTabBarViewController.m
//  Segment
//
//  Created by itclimb on 2017/11/1.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JJTabBarViewController.h"
#import "JJSegmentController.h"

@interface JJTabBarViewController ()

@end

@implementation JJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[[JJSegmentController alloc] init]];
    [self addChildViewController:nav1];
    
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[[JJSegmentController alloc] init]];
    [self addChildViewController:nav2];
    
    
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
