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
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.line = [[UIView alloc] init];
        [self.contentView addSubview:self.line];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(self.contentView);
    }];

}

@end
