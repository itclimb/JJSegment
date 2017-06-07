//
//  JJSegmentBaseController.m
//  Tools
//
//  Created by itclimb on 19/05/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "JJSegmentBaseController.h"
#import "Masonry.h"
@interface JJSegmentBaseController ()

@end

@implementation JJSegmentBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    UILabel *indexLabel = [UILabel new];
    [self.view addSubview:indexLabel];
    [indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    indexLabel.text = self.index;
}

@end
