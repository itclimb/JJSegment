//
//  JJSegmentHeadView.h
//  Tools
//
//  Created by itclimb on 19/05/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)

@protocol JJSegmentHeadViewDelegate <NSObject>

@required
- (NSInteger)jjSegmentNumber;
- (CGSize)jjSegmentItemSimeWithIndex:(NSInteger)index;
- (void)selectWithIndex:(NSInteger)index;
- (NSString *)textForCellWithIndex:(NSInteger)index;

@end

@interface JJSegmentHeadView : UIView

@property(nonatomic, weak) id<JJSegmentHeadViewDelegate> delegate;
@property(nonatomic, copy) UIColor *titleLabelColor;
@property(nonatomic, copy) UIColor *lineColor;

- (void)setSelectItemWithIndex:(NSInteger)index;
- (void)reloadData;

@end


//MARK: - cell
@interface JJSegmentHeadViewCell : UICollectionViewCell
//  标题
@property(nonatomic, strong) UILabel *titleLabel;
//  底部直线
@property(nonatomic, strong) UIView *line;

@end

