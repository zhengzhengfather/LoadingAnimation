//
//  DRAnimationBlockDelegate.h
//  VCTransitionTest
//
//  Created by yangtao on 14-11-12.
//  Copyright (c) 2014年 Yt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRAnimationBlockDelegate : NSObject

@property (copy) void(^start)(void);
@property (copy) void(^stop)(BOOL finish);

+(instancetype) animationDelegateWithBeginning:(void(^)(void)) beginning completion:(void(^)(BOOL finish)) completion;

@end
