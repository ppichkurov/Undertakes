//
//  UNDAuthViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 07.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDAuthViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKUIDelegate.h>
#import <WebKit/WKNavigationDelegate.h>
#import <WebKit/WKWebsiteDataStore.h>
#import "UNDNetworkRequestURLService.h"
#import "masonry.h"

@interface UNDAuthViewController () <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation UNDAuthViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self prepareUI];
    [self prepareWebView];
    [self clearWebViewCache];
    [self makeConstraints];
    [self loadAuthRequest];
}

- (void)prepareUI
{
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)clearWebViewCache
{
    NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                    WKWebsiteDataTypeDiskCache,
                                                    WKWebsiteDataTypeOfflineWebApplicationCache,
                                                    WKWebsiteDataTypeMemoryCache,
                                                    WKWebsiteDataTypeLocalStorage,
                                                    WKWebsiteDataTypeCookies,
                                                    WKWebsiteDataTypeSessionStorage,
                                                    WKWebsiteDataTypeIndexedDBDatabases,
                                                    WKWebsiteDataTypeWebSQLDatabases
                                                    ]];

    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        NSLog(@"King's cache clean");
    }];
}

- (void)prepareWebView
{
    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview: self.webView];
}

- (void)makeConstraints
{
    UIEdgeInsets paddings = UIEdgeInsetsMake(30, 0, 0, 0);
    [self.webView mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.edges.equalTo(self.view).with.insets(paddings);
     }];
}

- (void)loadAuthRequest
{
    NSURL *authUrl = [UNDNetworkRequestURLService getAuthVKRequestURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: authUrl];
    request.HTTPMethod = @"GET";
    [self.webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
{
    NSMutableString *urlString = [self.webView.URL.absoluteString mutableCopy];
    NSString *prefix = @"https://oauth.vk.com/blank.html#access_token=";
    
    if (![urlString hasPrefix: prefix])
    {
        return;
    }
    
    [urlString deleteCharactersInRange: NSMakeRange(0, prefix.length)];
    NSArray* urlParamArray = [urlString componentsSeparatedByString:@"&"];
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"VKToken" : urlParamArray[0] }];
}

@end
