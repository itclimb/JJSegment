//
//  JJSegmentHeadView.h
//  Tools
//
//  Created by itclimb on 19/05/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJSegmentHeadView;

#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)

@protocol JJSegmentHeadViewDelegate <NSObject>

@required
//  标签栏标签个数
- (NSInteger)JJSegmentNumber;
//  标签尺寸
- (CGSize)JJSegmentHeadView:(JJSegmentHeadView *)segmentHeadView itemSizeWithIndex:(NSInteger)index;
//  选中标签
- (void)JJSegmentHeadView:(JJSegmentHeadView *)segmentHeadView itemSelectWithIndex:(NSInteger)index;
//  标签栏的item
- (UICollectionViewCell *)JJSegmentHeadView:(JJSegmentHeadView *)segmentHeadView cellForItemAtIndexPath:(NSIndexPath *)indexPath withSelectIndex:(NSInteger)index;

@end

@interface JJSegmentHeadView : UIView

@property(nonatomic, weak) id<JJSegmentHeadViewDelegate> delegate;

/**
 选中标签栏的某个cell

 @param index 索引
 */
- (void)setSelectItemWithIndex:(NSInteger)index;

/**
 重新加载
 */
- (void)reloadData;

/**
 复用cell

 @param identifier 复用标识
 @param indexPath 复用索引
 @return cell
 */
- (UICollectionViewCell *)segmentHeadViewDequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

/**
 注册

 @param cellClass 注册类
 @param identifier 注册标识
 */
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

@end


