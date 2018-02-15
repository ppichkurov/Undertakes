//
//  UNDPromiseDataSourceOutputProtocol.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNDPromise+CoreDataClass.h"

@protocol UNDPromiseDataSourceOutputProtocol <NSObject>
@optional

- (void)changeCurrentMaintainerCollectionForPromise: (UNDPromise *)promise;

- (void)presentPromise:(UNDPromise *)promise;

- (void)addPromisCollectionViewWillDismissed:(NSString *)title fulltext:(NSString *)fullText;

@end
