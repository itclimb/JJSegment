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
#import "JJSegmentHeadViewCell.h"

@interface JJSegmentController ()<JJSegmentViewDelegate>

@property(nonatomic, weak) NSArray *titleDatas;

@end

@implementation JJSegmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *titleDatas = @[@"推荐视频",@"热点",@"直播",@"阿里巴巴",@"今日头条",@"腾讯视频"];
    self.titleDatas = titleDatas;
    JJSegmentView *segmentView = [[JJSegmentView alloc] initWithFrame:CGRectZero
                                                          andDelegate:self
                                                       withTitleDatas:titleDatas
                                                           headHeight:40
                                                           FontOfSize:17.0
                                                          SelectColor:nil];
    
    [self.view addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(64);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
    
}


#pragma mark - JJSegmentViewDelegate

- (UIViewController *)superViewController{
    return self;
}

- (UIViewController *)JJSegmentView:(JJSegmentView *)segmentView subViewControllerWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            JJSegmentBaseController *vc = [[JJSegmentBaseController alloc] init];
            vc.index = [NSString stringWithFormat:@"第%ld页",(long)index];
            return vc;
            break;
        }
        default:
        {
            JJSegmentBaseController *vc = [[JJSegmentBaseController alloc] init];
            vc.index = [NSString stringWithFormat:@"第%ld页",(long)index];
            return vc;
            break;
        }
    }
}

- (void)JJSegmentView:(JJSegmentView *)segmentView itemSelectWithIndex:(NSInteger)index{
    
    NSLog(@"----%ld",index);
}

@end
