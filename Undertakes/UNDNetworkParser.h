//
//  UNDNetworkParser.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNDParserOutputProtocol.h"
#import "UNDNetworkServiceIOProtocol.h"

@interface UNDNetworkParser : NSObject <UNDNetworkServiceOutputProtocol>

@property (nonatomic, weak) id<UNDParserOutputProtocol> outputDelegate;
@property (nonatomic, weak) NSManagedObjectID *currentPromiseID;

@end
