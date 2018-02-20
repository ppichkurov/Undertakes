//
//  UNDNetworkService.h
//  Undertakes
//
//  Created by Павел Пичкуров on 06.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNDNetworkServiceIOProtocol.h"


@interface UNDNetworkService : NSObject <UNDNetworkServiceInputProtocol, NSURLSessionDelegate, NSURLSessionDownloadDelegate>


/**
 * <p>Делегат, получающий респонсы от VK</p>
 */
@property (nonatomic, weak) id <UNDNetworkServiceOutputProtocol> outputDelegate;

@end
