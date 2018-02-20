//
//  UNDAuthViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 07.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDAuthViewController.h"
#import "UNDTemplatesUI.h"
#import "UNDHomeViewController.h"
#import "UNDAlreadyDoneTableViewController.h"
#import "UNDFriendsTableViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKUIDelegate.h>
#import <WebKit/WKNavigationDelegate.h>
#import <WebKit/WKWebsiteDataStore.h>
#import "UNDNetworkRequestURLService.h"
#import "UNDStringConstants.h"
#import "masonry.h"


@interface UNDAuthViewController () <WKUIDelegate, WKNavigationDelegate>


@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) UNDHomeViewController *homeViewController;
@property (nonatomic, strong) UNDAlreadyDoneTableViewController *alreadyDoneViewController;

@end

@implementation UNDAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSString *user = [UNDStringConstants getUserID];
    NSString *token = [UNDStringConstants getToken];

    if (!token || !user)
    {
        [self prepareWebView];
        [self clearWebViewCache];
        [self makeConstraints];
        [self loadAuthRequest];
    }
    else
    {
        [self presentMainTabBar];
    }

}

- (void)prepareUI
{
    self.view.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
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
    self.webView = nil;
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
    NSArray *urlParamArray = [urlString componentsSeparatedByString:@"&"];
    NSString *userId = [urlParamArray[2] componentsSeparatedByString:@"="][1];
    
    [[NSUserDefaults standardUserDefaults] setObject: urlParamArray[0] forKey:@"VKToken"];
    [[NSUserDefaults standardUserDefaults] setObject: userId forKey:@"VKUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self presentMainTabBar];
}

- (void)presentMainTabBar
{
    if (!self.homeViewController)
    {
        self.homeViewController = [UNDHomeViewController new];
        self.homeViewController.tabBarItem.image = [UIImage imageNamed:@"homeTabBarIcon"];
    }
    if (!self.alreadyDoneViewController)
    {
        self.alreadyDoneViewController = [UNDAlreadyDoneTableViewController new];
        self.alreadyDoneViewController.tabBarItem.image = [UIImage imageNamed:@"doneTabBarIcon"];
    }
    if (!self.tabBarController)
    {
        self.tabBarController = [UITabBarController new];
    }
    NSArray *viewControllersArray = @[self.homeViewController, self.alreadyDoneViewController];
    self.tabBarController.viewControllers = viewControllersArray;
    self.tabBarController.selectedIndex = 0;
    [self presentViewController:self.tabBarController animated:NO completion:^{
        NSLog(@"Presented");
    }];
}

@end
