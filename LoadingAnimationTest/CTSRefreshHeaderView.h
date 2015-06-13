//
//  LoadingView.h
//  LoadingAnimationTest
//
//  Created by administrator on 15/4/23.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TriggerRefreshBlock)();

@interface CTSRefreshHeaderView : UIView

@property (nonatomic) float dotOffset;
@property (nonatomic, strong) TriggerRefreshBlock refreshBlock;

- (void) ctsRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void) ctsRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void) refreshDidFinished;
@end


@protocol CTSRefreshHeaderViewDelegate

- (void) ctsRefreshTableHeaderDidTriggerRefresh:(CTSRefreshHeaderView*)view;
@end