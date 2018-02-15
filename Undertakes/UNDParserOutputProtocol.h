//
//  UNDParserOutputProtocol.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UNDParserOutputProtocol <NSObject>
@optional

- (void)listOfMansThatLikedPromise:(NSSet *)likeMans;

- (void)photosURLOfMan:(NSUInteger)userID thatLikedPromiseReceived:(NSString *)urlString;

@end
