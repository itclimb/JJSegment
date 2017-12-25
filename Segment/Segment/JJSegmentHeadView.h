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

@end

@interface JJSegmentHeadView : UIView

/**
 代理
 */
@property(nonatomic, weak) id<JJSegmentHeadViewDelegate> delegate;

/**
 初始化方法

 @param frame headView的尺寸
 @param fontSize 标签字体大小
 @return headView
 */
- (instancetype)initWithFrame:(CGRect)frame
                andTitleDatas:(NSArray *)titleDatas
                   fontOfSize:(CGFloat)fontSize
                 bgNomalColor:(UIColor *)bgNomalColor
                bgSelectColor:(UIColor *)bgSelectColor
              titleNomalColor:(UIColor *)titleNomalColor
             titleSelectColor:(UIColor *)titleSelectColor
               lineNomalColor:(UIColor *)lineNomalColor
              lineSelectColor:(UIColor *)lineSelectColor;
/**
 选中标签栏的某个cell

 @param index 索引
 */
- (void)setSelectItemWithIndex:(NSInteger)index;

/**
 重新加载
 */
- (void)reloadData;

@end


