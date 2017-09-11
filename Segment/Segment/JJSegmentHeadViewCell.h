//
//  JJSegmentHeadViewCell.h
//  Segment
//
//  Created by itclimb on 2017/7/31.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSegmentHeadViewCell : UICollectionViewCell

//  标题
@property(nonatomic, strong) UILabel *titleLabel;
//  底部直线
@property(nonatomic, strong) UIView *line;
//  标题字体大小
@property(nonatomic, assign) CGFloat fontSize;

@end
