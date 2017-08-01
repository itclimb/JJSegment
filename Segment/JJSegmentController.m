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
    JJSegmentView *segmentView = [[JJSegmentView alloc] initWithFrame:CGRectZero andDelegate:self withTitleDatas:titleDatas];
    
    [self.view addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(64);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
    
    [segmentView registerClass:[JJSegmentHeadViewCell class] forCellWithReuseIdentifier:@"jjSegmentCell"];
}


#pragma mark - JJSegmentViewDelegate

- (UIViewController *)superViewController{    
    return self;
}

- (UICollectionViewCell *)JJSegmentView:(JJSegmentView *)segmentView cellForItemAtIndexPath:(NSIndexPath *)indexPath withSelectIndex:(NSInteger)index{
    
    JJSegmentHeadViewCell *cell = (JJSegmentHeadViewCell *)[segmentView dequeueReusableCellWithReuseIdentifier:@"jjSegmentCell" forIndexPath:indexPath];

    cell.titleLabel.text = self.titleDatas[indexPath.row];

    if (index == indexPath.item) {
        cell.line.backgroundColor = [UIColor orangeColor];
        cell.titleLabel.textColor = [UIColor orangeColor];
//        [UIView animateWithDuration:0.3 animations:^{
//            cell.line.transform = CGAffineTransformMakeScale(1.2, 1.2);
//            cell.titleLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
//        }];
    }else {
        cell.line.backgroundColor = [UIColor clearColor];
        cell.titleLabel.textColor = [UIColor blackColor];
//        cell.line.transform = CGAffineTransformMakeScale(1.0, 1.0);
//        cell.titleLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
    return cell;
}

- (UIViewController *)JJSegmentView:(JJSegmentView *)segmentView subViewControllerWithIndex:(NSInteger)index{
    switch (index) {

        case 0:
        {
            JJSegmentBaseController *vc = [[JJSegmentBaseController alloc] init];
            vc.index = [NSString stringWithFormat:@"第%ld页",index];
            return vc;
        }
            break;

        default:
        {
            JJSegmentBaseController *vc = [[JJSegmentBaseController alloc] init];
            vc.index = [NSString stringWithFormat:@"第%ld页",index];
            return vc;
        }
            break;
    }
    
}

- (void)headTitleSelectWithIndex:(NSInteger)index{
    
    NSLog(@"----%ld",index);
}

@end
