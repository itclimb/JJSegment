//
//  JJSegmentManager.m
//  Segment
//
//  Created by itclimb on 2017/9/8.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JJSegmentManager.h"
#import "JJSegmentView.h"

@implementation JJSegmentManager

//MARK: - 单例
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

- (void)setSegmentHeadHeight:(CGFloat)segmentHeadHeight {
    _segmentHeadHeight = segmentHeadHeight;
    
}
@end
