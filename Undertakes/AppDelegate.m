//
//  AppDelegate.m
//  Undertakes
//
//  Created by Павел Пичкуров on 28.01.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "AppDelegate.h"
#import "UNDHomeViewController.h"
#import "UNDAuthViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong)  UITabBarController * tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    [self prepareTabBarController];
    [self selectRootControllerByToken];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)prepareTabBarController
{
    UNDHomeViewController *homeView = [UNDHomeViewController new];
    NSArray *viewControllersArray = @[homeView];
    self.tabBarController = [UITabBarController new];
    self.tabBarController.viewControllers = viewControllersArray;
}

- (void)selectRootControllerByToken
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKToken"];
    if (!token)
    {
        UNDAuthViewController *authViewController = [[UNDAuthViewController alloc] initWithMainViewController: self.tabBarController];
        self.window.rootViewController = authViewController;
    }
    else
    {
        self.window.rootViewController = self.tabBarController;
    }
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Undertakes"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
