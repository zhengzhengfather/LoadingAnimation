//
//  LoadingView.m
//  LoadingAnimationTest
//
//  Created by administrator on 15/4/23.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "CTSRefreshHeaderView.h"
#import "SpinerView.h"
#import "DotView.h"
#import "DRAnimationBlockDelegate.h"

#define PULL_AREA_HEIGTH 100

@implementation CTSRefreshHeaderView
{
    SpinerView *spinerView;
    DotView *dotView;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:232/255. green:233/255. blue:230/255. alpha:1];
        spinerView = [[SpinerView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        spinerView.center = CGPointMake(self.center.x, self.frame.size.height - 60);
        [self addSubview:spinerView];
        
        dotView = [[DotView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
        dotView.center = spinerView.center;
        [self addSubview:dotView];
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

- (void) setDotOffset:(float)dotOffset
{
    dotView.offset = dotOffset;
}

- (void)ctsRefreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        dotView.offset = -scrollView.contentOffset.y;
    }
    
    if (scrollView.contentOffset.y <= -PULL_AREA_HEIGTH) {
        
        scrollView.bounces = NO;
        UIEdgeInsets currentInsets = scrollView.contentInset;
        currentInsets.top = PULL_AREA_HEIGTH;
        scrollView.contentInset = currentInsets;
    }
//    NSLog(@"spinerView.y = %f",spinerView.center.y);
}

- (void)ctsRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= -PULL_AREA_HEIGTH && scrollView.userInteractionEnabled) {
    
        scrollView.userInteractionEnabled = NO;
        [self dotRecoverAnimation];
        if (_refreshBlock) {
            _refreshBlock();
        }
        [self performSelector:@selector(finish) withObject:nil afterDelay:2.3];
    }
}

- (void) finish
{
//    isFinishLoading = YES;
    [self refreshDidFinished];
}

- (void) dotRecoverAnimation
{

    [UIView animateWithDuration:.2f animations:^{
        
        dotView.center = spinerView.center;
    }completion:^(BOOL finish){
        [self keyframeAnimationWithView:dotView beginBlock:^{
            [spinerView startAnimation];
        }finishBlock:^(BOOL finished){
            [self rotationAnimation];
        }];

    }];
}

- (void) keyframeAnimationWithView:(UIView*) view beginBlock:(void(^)(void)) beginBlock finishBlock:(void(^)(BOOL finish))finishBlock
{
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue *p1 = [NSValue valueWithCGPoint:view.center];
    NSValue *p2 = [NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y-5)];
    NSValue *p3 = [NSValue valueWithCGPoint:view.center];
    
    [shakeAnimation setCalculationMode:kCAAnimationLinear];
    shakeAnimation.values = @[p1, p2, p3];
    shakeAnimation.keyTimes = @[@0,@0.5,@1];
    shakeAnimation.duration = 0.16f;
//    shakeAnimation.removedOnCompletion = NO;
//    shakeAnimation.fillMode = kCAFillModeForwards;
    shakeAnimation.delegate = [DRAnimationBlockDelegate animationDelegateWithBeginning:beginBlock completion:finishBlock];
    
    [view.layer addAnimation:shakeAnimation forKey:nil];
    view.center = spinerView.center;
}

- (void) rotationAnimation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 1;
    rotationAnimation.repeatCount = MAXFLOAT;//你可以设置到最大的整数值
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.delegate = [DRAnimationBlockDelegate animationDelegateWithBeginning:^{
        
    } completion:^(BOOL finish){
        if (finish) {
        }
    }];
    [spinerView.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}

- (void) refreshDidFinished
{
    UIScrollView *superScrollView = (UIScrollView*)self.superview;
    superScrollView.bounces = YES;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.];
    [UIView setAnimationDelegate:[DRAnimationBlockDelegate animationDelegateWithBeginning:nil completion:^(BOOL finish){
        superScrollView.userInteractionEnabled = YES;
        dotView.offset = 0;
        [spinerView stopAnimation];
    }]];
    UIEdgeInsets currentInsets = superScrollView.contentInset;
    currentInsets.top = 0;
    superScrollView.contentInset = currentInsets;
    
    [UIView commitAnimations];

}
@end
