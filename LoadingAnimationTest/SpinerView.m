//
//  SpinerView.m
//  LoadingAnimationTest
//
//  Created by administrator on 15/4/22.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "SpinerView.h"
#import "DRAnimationBlockDelegate.h"
@implementation SpinerView
{
    float originAngle;  // 起始角度
    NSInteger lineCount; // 线的数量
    NSTimer *timer;      // 执行动画的计时器
    float innerRadius;   // 菊花内径
    float outerRadius;   // 菊花外径
    float shrinkLength;  // 扩散的长度
    BOOL isShrink;  // 是否正在扩散
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isShrink = YES;
        lineCount = 10;
        originAngle = M_PI/2;
        shrinkLength = self.frame.size.height/10;
        innerRadius = self.frame.size.height/5;
        outerRadius = self.frame.size.height/5*2;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}

- (void) startAnimation
{
    if (!timer.isValid) {
        timer =[NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(update) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (void) stopAnimation
{
    [self.layer removeAllAnimations];
}

- (void) update
{
    if (innerRadius >= self.frame.size.height/5 && isShrink) {
        innerRadius += 0.4;
        outerRadius += 0.4;
    }
    if (innerRadius >= self.frame.size.height/5+shrinkLength || !isShrink) {
        innerRadius -= 0.4;
        outerRadius -= 0.4;
        isShrink = NO;
    }
    if (isShrink == NO && innerRadius <= self.frame.size.height/5) {
        innerRadius = self.frame.size.height/5;
        isShrink = YES;
        [timer invalidate];
    }

    [self setNeedsDisplay];
    
}
// 获取内圆的坐标
-(CGPoint) pointOnInnerCirecleWithAngel:(int) stage
{
    double r = innerRadius;
    double cx = self.frame.size.width/2;
    double cy = self.frame.size.height/2;
    double x = cx + r*cos(2*M_PI/lineCount*stage+originAngle);
    double y = cy + r*sin(2*M_PI/lineCount*stage+originAngle);
    return CGPointMake(x, y);
}

// 获取外圆的坐标
-(CGPoint) pointOnOuterCirecleWithAngel:(int) stage
{
    double r = outerRadius;
    double cx = self.frame.size.width/2;
    double cy = self.frame.size.height/2;
    double x = cx + r*cos(2*M_PI/lineCount*stage+originAngle);
    double y = cy + r*sin(2*M_PI/lineCount*stage+originAngle);
    return CGPointMake(x, y);
}

-(void) drawRect:(CGRect)rect
{
    CGPoint point;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [[UIColor grayColor] CGColor]);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 2.0);
    
    for (int i = 0 ; i<lineCount; ++i) {

        point = [self pointOnOuterCirecleWithAngel:i];
        CGContextMoveToPoint(ctx, point.x, point.y);
        point = [self pointOnInnerCirecleWithAngel:i];
        CGContextAddLineToPoint( ctx, point.x, point.y);
        CGContextStrokePath(ctx);
    }
}


@end
