//
//  JJSegmentView.m
//  Tools
//
//  Created by itclimb on 19/05/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "JJSegmentView.h"
#import "JJSegmentHeadView.h"
#import "Masonry.h"

@interface JJSegmentView()<JJSegmentHeadViewDelegate,UIScrollViewDelegate>

@property(nonatomic, strong) JJSegmentHeadView *jjSegmentHead;
@property(nonatomic, strong) UIScrollView *scrollBg;
@property(nonatomic, strong) UIView *container;

@end

@implementation JJSegmentView

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate withTitleDatas:(NSArray *)titleDatas
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.titleDatas = titleDatas;
    }
    return self;
}

//MARK: - Property Set
- (void)setTitleDatas:(NSArray *)titleDatas{
    _titleDatas = titleDatas;
    
    if (self.titleDatas.count <= 0) {
        return;
    }
    for (UIViewController *vc in [self.delegate superViewController].childViewControllers) {
        [vc removeFromParentViewController];
    }
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
        [self.jjSegmentHead reloadData];
    [self createUI];
}

- (void)createUI{
    
    self.jjSegmentHead = [[JJSegmentHeadView alloc] init];
    self.jjSegmentHead.titleLabelColor = self.headViewTitleLableColor;
    self.jjSegmentHead.lineColor = self.headViewLineColor;
    [self addSubview:self.jjSegmentHead];
    [self.jjSegmentHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    self.jjSegmentHead.delegate = self;
    
    UIScrollView *scrollBg = [[UIScrollView alloc] init];
    self.scrollBg = scrollBg;
    scrollBg.delegate = self;
    [self addSubview:scrollBg];
    scrollBg.pagingEnabled = YES;
    scrollBg.bounces = NO;
    scrollBg.showsHorizontalScrollIndicator = NO;
    [scrollBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.jjSegmentHead.mas_bottom);
    }];
    
    UIView *container = [UIView new];
    self.container = container;
    [scrollBg addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollBg);
        make.height.mas_equalTo(scrollBg);
    }];


    UIView *lastView = nil;
    for (int i = 0; i < self.titleDatas.count; i++) {
        
        UIViewController *baseVc = [self.delegate JJSegmentView:self subViewControllerWithIndex:i];
        [[self.delegate superViewController] addChildViewController:baseVc];
        [self.container addSubview:baseVc.view];
        [baseVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.mas_equalTo(self.container);
            make.width.mas_equalTo(ScreenWidth);
            if (i == 0) {
                make.leading.equalTo(self.container);
            } else {
                make.leading.equalTo(lastView.mas_trailing);
                if (i == self.titleDatas.count - 1) {
                    make.trailing.equalTo(self.container);
                }
            }
        }];
        lastView = baseVc.view;
    }
    
    if (self.container.subviews.count > 1) {
        [self.container.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    }
}


//MARK: - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.jjSegmentHead setSelectItemWithIndex:scrollView.contentOffset.x / ScreenWidth];
}


//MARK: - JJSegmentHeadViewDelegate
- (NSInteger)jjSegmentNumber{
    return self.titleDatas.count;
}
- (CGSize)jjSegmentItemSimeWithIndex:(NSInteger)index{
    NSString *str = [self.titleDatas objectAtIndex:index];
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return CGSizeMake(size.width + 25, 30);
}

- (void)selectWithIndex:(NSInteger)index{
    
    [self.scrollBg setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:NO];
    if (self.delegate && [self.delegate respondsToSelector:@selector(headTitleSelectWithIndex:)]) {
        [self.delegate headTitleSelectWithIndex:index];
    }
}
- (NSString *)textForCellWithIndex:(NSInteger)index{
    return [self.titleDatas objectAtIndex:index];
}

- (JJSegmentHeadViewCell *)JJSegmentHeadView:(UICollectionView *)segmentHeadView cellForItemAtIndexPath:(NSIndexPath *)indexPath withSelectIndex:(NSInteger)index{
    return [self.delegate JJSegmentView:segmentHeadView cellForItemAtIndexPath:indexPath withSelectIndex:index];
}

@end
