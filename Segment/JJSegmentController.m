//
//  JJSegmentController.m
//  Tools
//
//  Created by itclimb on 19/05/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "JJSegmentController.h"
#import "JJSegmentView.h"
#import "JJSegmentBaseController.h"
#import "Masonry.h"

@interface JJSegmentController ()<JJSegmentViewDelegate>

@end

@implementation JJSegmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *titleDatas = @[@"推荐",@"热点",@"直播",@"视频",@"娱乐",@"社会",@"头条号",@"问答",@"娱乐"];
    JJSegmentView *segmentView = [[JJSegmentView alloc] initWithFrame:CGRectZero andDelegate:self withTitleDatas:titleDatas];
    
    [self.view addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(64);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
    
}


#pragma mark - JJSegmentViewDelegate
//  指明父控制器
- (UIViewController *)superViewController{
    
    return self;
}

//  导航栏index 对应的子控制器
- (UIViewController *)subViewControllerWithIndex:(NSInteger)index{
    
    JJSegmentBaseController *vc = [[JJSegmentBaseController alloc] init];
    vc.index = [NSString stringWithFormat:@"第%ld页",index];
    return vc;
}

- (void)headTitleSelectWithIndex:(NSInteger)index{
    
    NSLog(@"----%ld",index);
}

@end
