//
//  ViewController.m
//  LoadingAnimationTest
//
//  Created by administrator on 15/4/22.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "ViewController.h"
#import "CTSRefreshHeaderView.h"
#import "CTSRefreshFooterView.h"
#import "CTSRefreshWebView.h"

@interface ViewController ()<UIWebViewDelegate,CTSRefreshWebViewDelegate>

@end

@implementation ViewController
{
//    CTSRefreshHeaderView *headerView;
//    CTSRefreshFooterView *footerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    scrollView.backgroundColor = [UIColor colorWithRed:217/255. green:180/255. blue:6/255. alpha:1];
//    scrollView.delegate = self;
//    scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, 1000);
//    [self.view addSubview:scrollView];
//    
//    // Do any additional setup after loading the view, typically from a nib.
//    headerView = [[CTSRefreshHeaderView alloc] initWithFrame:CGRectMake(0, -scrollView.frame.size.height, self.view.frame.size.width, scrollView.frame.size.height)];
//    [scrollView addSubview:headerView];
//    
//    footerView = [[CTSRefreshFooterView alloc] initWithFrame:CGRectMake(0, scrollView.contentSize.height, self.view.frame.size.width, scrollView.frame.size.height)];
//    [scrollView addSubview:footerView];
    
    CTSRefreshWebView *webView = [[CTSRefreshWebView alloc] initWithFrame:self.view.bounds];
    webView.ctsRefreshWebViewDelegate = self;
    webView.scalesPageToFit = YES;
    [webView setWebViewDelegate:self];
    webView.isShowHeader = YES;
    webView.isShowFooter = YES;
    [self.view addSubview:webView];
}

- (void)webViewDidStartLoad:(CTSRefreshWebView *)webView
{

}

- (void)webViewDidFinishLoad:(CTSRefreshWebView *)webView
{
    [webView didFinishLoading];
}

- (void)webView:(CTSRefreshWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma -mark CTSRefreshWebViewDelegate

- (void)ctsRefreshWebViewDidTriggerRefresh:(CTSRefreshWebView*)webView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [webView loadRequest:request];
}

- (void)ctsRefreshWebViewDidTriggerLoadMore:(CTSRefreshWebView*)webView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [webView loadRequest:request];
}

- (void) clickButton
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
