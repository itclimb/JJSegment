//
//  JJSegmentView.h
//  Tools
//
//  Created by itclimb on 19/05/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJSegmentView;

@protocol JJSegmentViewDelegate <NSObject>

@required
//  指明父控制器
- (UIViewController *)superViewController;
//  子控制器
- (UIViewController *)JJSegmentView:(JJSegmentView *)segmentView subViewControllerWithIndex:(NSInteger)index;
//  标签栏的item
- (UICollectionViewCell *)JJSegmentView:(JJSegmentView *)segmentView cellForItemAtIndexPath:(NSIndexPath *)indexPath withSelectIndex:(NSInteger)index;

@optional
//  选择标签栏标签
- (void)JJSegmentView:(JJSegmentView *)segmentView itemSelectWithIndex:(NSInteger)index;

@end


@interface JJSegmentView : UIView
//  代理
@property(nonatomic, weak) id<JJSegmentViewDelegate> delegate;

/**
 初始化方法

 @param frame 视图尺寸
 @param delegate 代理
 @param titleDatas 标签数据
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate withTitleDatas:(NSArray *)titleDatas;


/**
 复用cell

 @param identifier 复用标识
 @param indexPath 复用标签
 @return cell
 */
- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;


/**
 注册

 @param cellClass 注册的类
 @param identifier 注册标识
 */
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

@end
