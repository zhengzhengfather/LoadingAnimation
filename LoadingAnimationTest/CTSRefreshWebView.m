//
//  CTSRefreshWebView.m
//  LoadingAnimationTest
//
//  Created by administrator on 15/4/24.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "CTSRefreshWebView.h"

@interface CTSRefreshWebView (Private) <UIScrollViewDelegate>


- (void) config;
@end

@implementation CTSRefreshWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    
    return self;
}

- (void) config
{
    __weak CTSRefreshWebView *weakSelf = self;
    
    headerView = [[CTSRefreshHeaderView alloc] initWithFrame:CGRectMake(0, -self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    headerView.refreshBlock = ^{
        [weakSelf.ctsRefreshWebViewDelegate ctsRefreshWebViewDidTriggerRefresh:weakSelf];
        weakSelf.refreshState = CTSRefreshWebViewStateHeader;
    };
    
    footerView = [[CTSRefreshFooterView alloc] initWithFrame:CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    footerView.loadMoreBlock = ^{
        [weakSelf.ctsRefreshWebViewDelegate ctsRefreshWebViewDidTriggerLoadMore:weakSelf];
        weakSelf.refreshState = CTSRefreshWebViewStateFooter;
    };
    self.scrollView.delegate = self;
}

- (void) setIsShowHeader:(BOOL)isShowHeader
{
    if (isShowHeader) {
        [self.scrollView addSubview:headerView];
    }
}

- (void) setIsShowFooter:(BOOL)isShowFooter
{
    if (isShowFooter) {
        [self.scrollView addSubview:footerView];
    }
}

- (void)setWebViewDelegate:(id <UIWebViewDelegate>)delegate
{
    [super setDelegate:delegate];
}

- (void) didFinishLoading
{
    switch (self.refreshState) {
        case CTSRefreshWebViewStateHeader:
        {
            [headerView refreshDidFinished];
        }
            break;
        case CTSRefreshWebViewStateFooter:
        {
            [footerView loadMoreDidFinish];
        }
            break;
        default:
            break;
    }
}

#pragma mark- UIScrollViewDegelate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (headerView.superview) {
        [headerView ctsRefreshScrollViewDidScroll:scrollView];
    }
    if (footerView.superview) {
        [footerView ctsRefreshScrollViewDidScroll:scrollView];
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (headerView.superview) {
        [headerView ctsRefreshScrollViewDidEndDragging:scrollView];
    }
    if (footerView.superview) {
        [footerView ctsRefreshScrollViewDidEndDragging:scrollView];
    }
}
@end
