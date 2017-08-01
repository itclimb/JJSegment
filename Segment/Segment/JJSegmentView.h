//
//  JJSegmentView.h
//  Tools
//
//  Created by itclimb on 19/05/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JJSegmentHeadViewCell.h"
@class JJSegmentView;

@protocol JJSegmentViewDelegate <NSObject>

@required

//  指明父控制器
- (UIViewController *)superViewController;

//  导航栏index对应的子控制器
- (UIViewController *)JJSegmentView:(JJSegmentView *)segmentView subViewControllerWithIndex:(NSInteger)index;

//  标签栏的cell
- (UICollectionViewCell *)JJSegmentView:(JJSegmentView *)segmentView cellForItemAtIndexPath:(NSIndexPath *)indexPath withSelectIndex:(NSInteger)index;

@optional

//  选择标签栏标签
- (void)headTitleSelectWithIndex:(NSInteger)index;

@end


@interface JJSegmentView : UIView

//Delegate
@property(nonatomic, weak) id<JJSegmentViewDelegate> delegate;

//The headView title color, default is yellow.
@property(nonatomic, copy) UIColor *headViewTitleLableColor;

//The headView line color, default is yellow.
@property(nonatomic, copy) UIColor *headViewLineColor;

//Datas,default is zero.
@property(nonatomic, strong) NSArray *titleDatas;

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate withTitleDatas:(NSArray *)titleDatas;

- (UICollectionViewCell *)segmentViewDequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *_Nullable)identifier;

@end
