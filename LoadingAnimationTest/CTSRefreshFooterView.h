//
//  CTSRefreshFooterView.h
//  LoadingAnimationTest
//
//  Created by administrator on 15/4/24.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TriggerLoadMoreBlock)();

@interface CTSRefreshFooterView : UIView

@property (nonatomic) float dotOffset;
@property (nonatomic, strong) TriggerLoadMoreBlock loadMoreBlock;

//- (void) dotRecoverAnimation;

- (void)ctsRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)ctsRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void) loadMoreDidFinish;
@end


@protocol CTSRefreshFooterViewDelegate

- (void)ctsRefreshTableFooterDidTriggerRefresh:(CTSRefreshFooterView*)view;

@end
