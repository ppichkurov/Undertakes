//
//  UNDNetworkService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 06.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDNetworkService.h"

@interface UNDNetworkService ()

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSURLSessionDownloadTask *loadWallTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *loadFriendListTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *loadPhotoTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *loadLikeUsersTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *likePromiseTask;

@end

@implementation UNDNetworkService

- (void)configureURLSession
{
    if (!self.urlSession)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.allowsCellularAccess = YES;
        configuration.HTTPAdditionalHeaders = @{ @"Accept" : @"application/json" };
        
        self.urlSession = [NSURLSession sessionWithConfiguration:configuration
                                                        delegate:self
                                                   delegateQueue:nil];
    }
}

//- (void)getVkAccessToken
//{
//    if (!self.urlSession)
//    {
//        [self configureURLSession];
//    }
//
//    NSURL *url = [[NSURL alloc] initWithString: UNDAuthUrlString];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    request.HTTPMethod = @"GET";

//    self.downloadTask = [self.urlSession downloadTaskWithRequest:request];
//    [self.downloadTask resume];
//}




- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.outputDelegate loadWallDidFinishWithData:data];
    });

    [session finishTasksAndInvalidate];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
}

@end
