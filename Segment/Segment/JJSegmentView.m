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
//  标签栏
@property(nonatomic, strong) JJSegmentHeadView *jjSegmentHead;
//  滚动视图
@property(nonatomic, strong) UIScrollView *scrollBg;
//  视图容器
@property(nonatomic, strong) UIView *container;
//  标签栏数据
@property(nonatomic, strong) NSArray *titleDatas;
//  标签栏高度
@property(nonatomic, assign) CGFloat headHeight;
//  标签栏字体
@property(nonatomic, assign) CGFloat fontSize;
//  标签栏未选中色
@property(nonatomic, strong) UIColor *headBgNomalColor;
//  标签栏选中色
@property(nonatomic, strong) UIColor *headBgSelectColor;
//  标签栏字体未选中色
@property(nonatomic, strong) UIColor *headTitleNomalColor;
//  标签栏字体选中色
@property(nonatomic, strong) UIColor *headTitleSelectColor;
//  标签栏下划线未选中色
@property(nonatomic, strong) UIColor *headLineNomalColor;
//  标签栏下划线选中色
@property(nonatomic, strong) UIColor *headLineSelectColor;


@end

@implementation JJSegmentView

- (instancetype)initWithFrame:(CGRect)frame
                  andDelegate:(id)delegate
                   titleDatas:(NSArray *)titleDatas
                   headHeight:(CGFloat)headHeight
                   fontOfSize:(CGFloat)fontSize
               itemNomalColor:(UIColor *)nomalColor
              itemSelectColor:(UIColor *)selectColor
{
    if ([self initWithFrame:frame
                andDelegate:delegate
                 titleDatas:titleDatas
                 headHeight:headHeight
                 fontOfSize:fontSize
           headBgNomalColor:[UIColor whiteColor]
          headBgSelectColor:[UIColor whiteColor]
        headTitleNomalColor:nomalColor
       headTitleSelectColor:selectColor
         headLineNomalColor:[UIColor clearColor]
        headLineSelectColor:selectColor]) {
        //do nothing
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                  andDelegate:(id)delegate
                   titleDatas:(NSArray *)titleDatas
                   headHeight:(CGFloat)headHeight
                   fontOfSize:(CGFloat)fontSize
             headBgNomalColor:(UIColor *)headBgNomalColor
            headBgSelectColor:(UIColor *)headBgSelectColor
          headTitleNomalColor:(UIColor *)headTitleNomalColor
         headTitleSelectColor:(UIColor *)headTitleSelectColor
           headLineNomalColor:(UIColor *)headLineNomalColor
          headLineSelectColor:(UIColor *)headLineSelectColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headHeight = headHeight;
        self.fontSize = fontSize;
        self.delegate = delegate;
        self.headBgNomalColor = headBgNomalColor;
        self.headBgSelectColor = headBgSelectColor;
        self.headTitleNomalColor = headTitleNomalColor;
        self.headTitleSelectColor = headTitleSelectColor;
        self.headLineNomalColor = headLineNomalColor;
        self.headLineSelectColor = headLineSelectColor;
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

//MARK: - 创建子控件
- (void)createUI{
    
    self.jjSegmentHead = [[JJSegmentHeadView alloc] initWithFrame:CGRectZero andTitleDatas:_titleDatas fontOfSize:self.fontSize bgNomalColor:self.headBgNomalColor bgSelectColor:self.headBgSelectColor titleNomalColor:self.headTitleNomalColor titleSelectColor:self.headTitleSelectColor lineNomalColor:self.headLineNomalColor lineSelectColor:self.headLineSelectColor];
    [self addSubview:self.jjSegmentHead];
    [self.jjSegmentHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self);
        make.height.mas_equalTo(self.headHeight?:40);
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.jjSegmentHead setSelectItemWithIndex:scrollView.contentOffset.x / ScreenWidth];
}


#pragma mark -  JJSegmentHeadViewDelegate

- (NSInteger)JJSegmentNumber{
    return self.titleDatas.count;
}

- (CGSize)JJSegmentHeadView:(JJSegmentHeadView *)segmentHeadView itemSizeWithIndex:(NSInteger)index{
    CGFloat total = 0;
    for (NSString *subStr in self.titleDatas) {
        UIFont *subFont = [UIFont systemFontOfSize:self.fontSize?:17.0];
        CGSize subSize = [subStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:subFont, NSFontAttributeName, nil]];
        total += (subSize.width + 25);
    }
    if (total < [UIScreen mainScreen].bounds.size.width) {
        return CGSizeMake(ScreenWidth / self.titleDatas.count, self.headHeight?:40);
    }else {
        NSString *str = [self.titleDatas objectAtIndex:index];
        UIFont *font = [UIFont systemFontOfSize:self.fontSize?:17.0];
        CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
        return CGSizeMake(size.width + 25, self.headHeight?:40);
    }
}

- (void)JJSegmentHeadView:(JJSegmentHeadView *)segmentHeadView itemSelectWithIndex:(NSInteger)index{
    
    [self.scrollBg setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:NO];
    [self.delegate JJSegmentView:self itemSelectWithIndex:index];
}

@end
