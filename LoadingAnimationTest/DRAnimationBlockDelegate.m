//
//  DRAnimationBlockDelegate.m
//  VCTransitionTest
//
//  Created by yangtao on 14-11-12.
//  Copyright (c) 2014年 Yt. All rights reserved.
//

#import "DRAnimationBlockDelegate.h"
@import UIKit;

@implementation DRAnimationBlockDelegate

+(instancetype) animationDelegateWithBeginning:(void(^)(void)) beginning completion:(void(^)(BOOL finish)) completion
{
    DRAnimationBlockDelegate *delegate = [DRAnimationBlockDelegate new];
    delegate.start = beginning;
    delegate.stop  = completion;
    return delegate;
}

- (void)animationDidStart:(CAAnimation *)anim
{
    if (self.start) {
        self.start();
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.stop) {
        self.stop(flag);
    }
}

@end
