//
//  UNDNetworkService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 06.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDNetworkService.h"
#import "UNDNetworkRequestURLService.h"

@interface UNDNetworkService ()

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSURLSessionDownloadTask *loadWallTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *loadFriendListTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *loadPhotoTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *loadLikeUsersTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *likePromiseTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *postPromiseTask;

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

- (void)createPromiseOnTheUserWallWithTitle:(NSString *)title fulltext:(NSString *)fullText
{
    if (!self.urlSession)
    {
        [self configureURLSession];
    }
    NSURL *url = [UNDNetworkRequestURLService getCreatePromiseOnTheUserWallRequestURL:title fulltext:fullText];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Contet-Type"];
    self.postPromiseTask = [self.urlSession downloadTaskWithRequest:request];
    [self.postPromiseTask resume];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (downloadTask == self.postPromiseTask)
        {
            [self.outputDelegate loadPostPromiseOnUserWallFinishWithData:data];
        }
    });

    [session finishTasksAndInvalidate];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"Error: %@",error);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
}

@end
