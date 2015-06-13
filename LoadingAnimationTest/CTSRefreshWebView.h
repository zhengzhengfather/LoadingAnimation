//
//  CTSRefreshWebView.h
//  LoadingAnimationTest
//
//  Created by administrator on 15/4/24.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTSRefreshHeaderView.h"
#import "CTSRefreshFooterView.h"

@class CTSRefreshWebView;

typedef enum : NSUInteger {
    CTSRefreshWebViewStateHeader,
    CTSRefreshWebViewStateFooter,
} CTSRefreshWebViewState;

@protocol CTSRefreshWebViewDelegate <NSObject>

/* After one of the delegate methods is invoked a loading animation is started, to end it use the respective status update property */
- (void)ctsRefreshWebViewDidTriggerRefresh:(CTSRefreshWebView*)refreshWebView;
- (void)ctsRefreshWebViewDidTriggerLoadMore:(CTSRefreshWebView*)refreshWebView;

@end

@interface CTSRefreshWebView : UIWebView
{
    CTSRefreshHeaderView *headerView;
    CTSRefreshFooterView *footerView;
}
@property (nonatomic) CTSRefreshWebViewState refreshState;
@property (nonatomic)BOOL isShowHeader;
@property (nonatomic)BOOL isShowFooter;
@property (nonatomic, assign) id<CTSRefreshWebViewDelegate> ctsRefreshWebViewDelegate;
- (void)setWebViewDelegate:(id <UIWebViewDelegate>)delegate;
- (void) didFinishLoading;
@end


