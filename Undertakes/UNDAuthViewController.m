//
//  UNDAuthViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 07.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDAuthViewController.h"
#import "UNDHomeViewController.h"
#import "UNDAlreadyDoneTableViewController.h"
#import "UNDFriendsTableViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKUIDelegate.h>
#import <WebKit/WKNavigationDelegate.h>
#import <WebKit/WKWebsiteDataStore.h>
#import "UNDNetworkRequestURLService.h"
#import "masonry.h"

@interface UNDAuthViewController () <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) UNDHomeViewController *homeViewController;
@property (nonatomic, strong) UNDAlreadyDoneTableViewController *alreadyDoneViewController;
@property (nonatomic, strong) UNDFriendsTableViewController *friendsViewController;

@end

@implementation UNDAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKToken"];
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKUser"];
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
    self.view.backgroundColor = UIColor.grayColor;
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

- (void)saveUserInfo
{
    
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
        self.homeViewController.tabBarItem.title = @"Home";
    }
    if (!self.alreadyDoneViewController)
    {
        self.alreadyDoneViewController = [UNDAlreadyDoneTableViewController new];
        self.alreadyDoneViewController.tabBarItem.title = @"Done";
    }
    if (!self.friendsViewController)
    {
        self.friendsViewController = [UNDFriendsTableViewController new];
        self.friendsViewController.tabBarItem.title = @"Friends";
    }
    if (!self.tabBarController)
    {
        self.tabBarController = [UITabBarController new];
    }
    NSArray *viewControllersArray = @[self.friendsViewController, self.homeViewController, self.alreadyDoneViewController];
    self.tabBarController.viewControllers = viewControllersArray;
    [self presentViewController:self.tabBarController animated:NO completion:^{
        NSLog(@"Presented");
    }];
}

@end
