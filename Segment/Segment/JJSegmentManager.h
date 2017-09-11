//
//  JJSegmentManager.h
//  Segment
//
//  Created by itclimb on 2017/9/8.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJSegmentView.h"
#import "JJSegmentHeadView.h"
#import "JJSegmentHeadViewCell.h"


@interface JJSegmentManager : NSObject

@property(nonatomic, assign) CGFloat segmentHeadHeight;
@property(nonatomic, strong) JJSegmentView *segmentView;

@end
