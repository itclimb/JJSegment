//
//  JJSegmentHeadViewCell.m
//  Segment
//
//  Created by itclimb on 2017/7/31.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JJSegmentHeadViewCell.h"
#import "Masonry.h"

@implementation JJSegmentHeadViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-4);
        }];
        
        self.line = [[UIView alloc] init];
        [self.contentView addSubview:self.line];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.leading.trailing.mas_equalTo(self.contentView);
            make.height.mas_equalTo(2);
        }];
    }
    
    return self;
}

@end
