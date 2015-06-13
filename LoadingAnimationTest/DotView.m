//
//  DotView.m
//  LoadingAnimationTest
//
//  Created by administrator on 15/4/23.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "DotView.h"

@implementation DotView
{
    float lastOffset; // 上一次的偏移量
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.cornerRadius = 4.f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:217/255. green:180/255. blue:6/255. alpha:1];
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setOffset:(float)offset
{
    if (offset != 0) {
        self.center = CGPointMake(self.center.x, self.center.y+(offset-lastOffset)/2.5);
    }
    lastOffset = offset;
}

@end
