//
//  UNDCoreDataRequestServiceTests.m
//  UndertakesTests
//
//  Created by Павел Пичкуров on 17.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UNDCoreDataRequestService.h"
#import "UNDStringConstants.h"
#import "Expecta.h"
#import "OCMock.h"


@interface UNDCoreDataRequestService (Tests)

+ (NSFetchRequest *)getRequestByEntityName:(NSString *) entityName;

@end

@interface UNDCoreDataRequestServiceTests : XCTestCase

@end

@implementation UNDCoreDataRequestServiceTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}


#pragma mark - + (NSFetchRequest *)getRequestByEntityName:(NSString *) entityName

- (void)testGetRequestByEntityNameNilName
{
    NSFetchRequest *request = [UNDCoreDataRequestService getRequestByEntityName:nil];
    
    expect(request).to.beNil();
}

- (void)testGetRequestByEntityNameEmptyName
{
    NSFetchRequest *request = [UNDCoreDataRequestService getRequestByEntityName:@""];
    
    expect(request).to.beNil();
}

- (void)testGetRequestByEntityNameNotInCoreData
{
    id descriptionClass = OCMClassMock([NSEntityDescription class]);
    id context = OCMClassMock([NSManagedObjectContext class]);
    
    OCMStub([descriptionClass entityForName: @"dsasdasd" inManagedObjectContext:context]).andReturn(nil);
    
    NSFetchRequest *request = [UNDCoreDataRequestService getRequestByEntityName:@"dsasdasd"];
    
    expect(request).to.beNil();
}


//+ (NSFetchRequest *)getRequestByEntityName:(NSString *) entityName
//{
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName: entityName inManagedObjectContext:self.coreDataContext];
//    if (!entity)
//    {
//        return nil;
//    }
//    [fetchRequest setEntity:entity];
//    return fetchRequest;
//}
//


#pragma mark - + (NSFetchRequest *)userPromisesRequest

- (void)testUserPromisesRequestNilUser
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    
    OCMStub([stringConstantClass getUserID]).andReturn(nil);
    
    NSFetchRequest *request = [UNDCoreDataRequestService userPromisesRequest];
    
    expect(request).to.beNil();
}


- (void)testUserPromisesRequestNilRequest
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    id selfClass = OCMClassMock([UNDCoreDataRequestService class]);
    
    OCMStub([stringConstantClass getUserID]).andReturn(@"123123");
    OCMStub([selfClass getRequestByEntityName:@"UNDPromise"]).andReturn(nil);
    
    NSFetchRequest *request = [UNDCoreDataRequestService userPromisesRequest];
    
    expect(request).to.beNil();
}

//- (void)testUserPromisesRequestNilPredicate
//{
//    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
//    id selfClass = OCMClassMock([UNDCoreDataRequestService class]);
//    id predicateClass = OCMClassMock([NSPredicate class]);
//    id req = OCMClassMock([NSFetchRequest class]);
//    OCMStub([stringConstantClass getUserID]).andReturn(@"123123");
//    OCMStub([selfClass getRequestByEntityName:@"UNDPromise"]).andReturn(req);
//    
//    // не подхватывается
//    OCMStub([predicateClass predicateWithFormat:@"ownerVkID CONTAINS %@", @"123123"]).andReturn(nil);
//
//    NSFetchRequest *request = [UNDCoreDataRequestService userPromisesRequest];
//    
//    expect(request).to.beNil();
//}

- (void)testUserPromisesRequestNormal
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    id selfClass = OCMClassMock([UNDCoreDataRequestService class]);
    id predicateClass = OCMClassMock([NSPredicate class]);
    id predicate = OCMClassMock([NSPredicate class]);
    id req = OCMClassMock([NSFetchRequest class]);
    OCMStub([stringConstantClass getUserID]).andReturn(@"123123");
    OCMStub([selfClass getRequestByEntityName:@"UNDPromise"]).andReturn(req);
    
    // не подхватывается
    OCMStub([predicateClass predicateWithFormat:(@"ownerVkID CONTAINS %@", @"123123")]).andReturn(predicate);
    
    NSFetchRequest *request = [UNDCoreDataRequestService userPromisesRequest];
    
    expect(request).toNot.beNil();
}

//+ (NSFetchRequest *)userPromisesRequest
//{
//    NSString *user = [UNDStringConstants getUserID];
//
//    if (!user)
//    {
//        return nil;
//    }
//
//    NSFetchRequest *fetchRequest = [self getRequestByEntityName:@"UNDPromise"];
//
//    if (!fetchRequest)
//    {
//        return nil;
//    }
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ownerVkID CONTAINS %@", user];
//    [fetchRequest setPredicate:predicate];
//
//    if (!predicate)
//    {
//        return nil;
//    }
//
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate"
//                                                                   ascending:NO];
//    fetchRequest.sortDescriptors = @[sortDescriptor];
//    return fetchRequest;
//}
//


#pragma marl - promiseLikeManRequest

- (void)testPromiseLikeManRequestLikeManIDNil
{
    NSFetchRequest *request = [UNDCoreDataRequestService promiseLikeManRequest:nil];
    
    expect(request).to.beNil();
}

- (void)testPromiseLikeManRequestLikeManIDEmpty
{
    NSFetchRequest *request = [UNDCoreDataRequestService promiseLikeManRequest:@""];
    
    expect(request).to.beNil();
}

- (void)testPromiseLikeManRequestLikeManIDNotNumeric
{
    NSFetchRequest *request = [UNDCoreDataRequestService promiseLikeManRequest:@"jhfjfd"];
    
    expect(request).to.beNil();
}

- (void)testPromiseLikeManRequestNilRequest
{
    id selfClass = OCMClassMock([UNDCoreDataRequestService class]);
    
    OCMStub([selfClass getRequestByEntityName:@"UNDLikeMan"]).andReturn(nil);

    NSFetchRequest *request = [UNDCoreDataRequestService promiseLikeManRequest:@"123123"];
    
    expect(request).to.beNil();
}

- (void)testPromiseLikeManRequestNormal
{
    id selfClass = OCMClassMock([UNDCoreDataRequestService class]);
    id req = OCMClassMock([NSFetchRequest class]);
    
    OCMStub([selfClass getRequestByEntityName:@"UNDLikeMan"]).andReturn(req);
    
    NSFetchRequest *request = [UNDCoreDataRequestService promiseLikeManRequest:@"123123"];
    
    expect(request).toNot.beNil();
}

//+ (NSFetchRequest *)promiseLikeManRequest:(NSString *)likeManID
//{
//    NSFetchRequest *fetchRequest = [self getRequestByEntityName:@"UNDLikeMan"];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"vkID CONTAINS %@", likeManID];
//    [fetchRequest setPredicate:predicate];
//    return fetchRequest;
//}

@end
