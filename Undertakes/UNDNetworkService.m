//
//  UNDNetworkService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 06.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDNetworkService.h"
#import "UNDNetworkRequestURLService.h"


static NSString *UNDPostPromiseToWallDescription = @"UNDPostPromiseToWallDescription";
static NSString *UNDUsersThatLikeWallDescription = @"UNDUsersThatLikeWallDescription";
static NSString *UNDUsersURLPhotoDescription = @"UNDUsersURLPhotoDescription";
static NSString *UNDPhotoHashTagUserID = @"UNDPhoto#%lu";


@interface UNDNetworkService ()

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation UNDNetworkService


#pragma mark - NSURLSession configuration

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

- (void)prepareTaskWithURL:(NSURL *)url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Contet-Type"];
    self.downloadTask = [self.urlSession downloadTaskWithRequest:request];
}


#pragma mark - UNDNetworkServiceInputProtocol

- (void)createPromiseOnTheUserWallWithTitle:(NSString *)title fulltext:(NSString *)fullText
{
    if (!self.urlSession)
    {
        [self configureURLSession];
    }
    NSURL *url = [UNDNetworkRequestURLService getCreatePromiseOnTheUserWallRequestURL:title fulltext:fullText];
    
    [self prepareTaskWithURL:url];
    self.downloadTask.taskDescription = UNDPostPromiseToWallDescription;
    [self.downloadTask resume];
}

- (void)getUsersThatLikeField:(NSUInteger)fieldID
{
    if (!self.urlSession)
    {
        [self configureURLSession];
    }
    NSURL *url = [UNDNetworkRequestURLService getUsersLikeFieldRequestURL:fieldID];
    
    [self prepareTaskWithURL:url];
    self.downloadTask.taskDescription = UNDUsersThatLikeWallDescription;
    [self.downloadTask resume];
    
}

- (void)getUserPhotoURL:(NSUInteger)userID
{
    if (!self.urlSession)
    {
        [self configureURLSession];
    }
    NSURL *url = [UNDNetworkRequestURLService getUserPhotoRequestURL:userID];
    
    [self prepareTaskWithURL:url];
    self.downloadTask.taskDescription = UNDUsersURLPhotoDescription;
    [self.downloadTask resume];
}

- (void)getPhotoByURL:(NSString *)urlString userID:(NSUInteger)userID
{
    if (!self.urlSession)
    {
        [self configureURLSession];
    }
    NSLog(@"try to download: %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    self.downloadTask = [self.urlSession downloadTaskWithURL:url];
    self.downloadTask.taskDescription = [NSString stringWithFormat:UNDPhotoHashTagUserID, userID];
    [self.downloadTask resume];
}


#pragma mark - NSURLSession and DowloadTask delegates

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
    NSData *data = [NSData dataWithContentsOfURL:location];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        if ([downloadTask.taskDescription isEqualToString: UNDPostPromiseToWallDescription])
        {
            [self.outputDelegate loadPostPromiseOnUserWallFinishWithData:data];
        }
        else if ([downloadTask.taskDescription isEqualToString: UNDUsersThatLikeWallDescription])
        {
            [self.outputDelegate loadUsersThatLikeFieldDidFinishWithData:data];
        }
        else if ([downloadTask.taskDescription isEqualToString: UNDUsersURLPhotoDescription])
        {
            [self.outputDelegate loadUserPhotoURLDidFinishWithData:data];
        }
        else if ([downloadTask.taskDescription containsString: @"UNDPhoto#"])
        {
            [self.outputDelegate loadPhotoDidFinishWithData:data taskDescription: downloadTask.taskDescription];
        }
//    });
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"Error: %@ with taskID: %lu", error, task.taskIdentifier);
//    [session finishTasksAndInvalidate];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
}

@end
