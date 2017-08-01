//
//  JJSegmentHeadView.h
//  Tools
//
//  Created by itclimb on 19/05/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JJSegmentHeadViewCell.h"
@class JJSegmentHeadView;

#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)

@protocol JJSegmentHeadViewDelegate <NSObject>

@required
- (NSInteger)jjSegmentNumber;
- (CGSize)jjSegmentItemSimeWithIndex:(NSInteger)index;
- (void)selectWithIndex:(NSInteger)index;
- (NSString *)textForCellWithIndex:(NSInteger)index;

//  头部标签协议
- (UICollectionViewCell *)JJSegmentHeadView:(JJSegmentHeadView *)segmentHeadView cellForItemAtIndexPath:(NSIndexPath *)indexPath withSelectIndex:(NSInteger) index;

@end

@interface JJSegmentHeadView : UIView

@property(nonatomic, weak) id<JJSegmentHeadViewDelegate> delegate;
@property(nonatomic, copy) UIColor *titleLabelColor;
@property(nonatomic, copy) UIColor *lineColor;

- (void)setSelectItemWithIndex:(NSInteger)index;

- (void)reloadData;

- (UICollectionViewCell *)segmentHeadViewDequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

@end


