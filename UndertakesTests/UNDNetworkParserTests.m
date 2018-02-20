//
//  UNDNetworkParserTests.m
//  UndertakesTests
//
//  Created by Павел Пичкуров on 15.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "Expecta.h"
#import "OCMock.h"
#import "UNDNetworkParser.h"
#import "UNDPromise+CoreDataClass.h"
#import "UNDCoreDataService.h"
#import "UNDStringConstants.h"


@interface UNDNetworkParser (Tests)


- (NSDictionary *)parseResponseFromVK:(NSData *)data;
- (BOOL)isCurrentPromiseSet;
- (NSManagedObjectID *)currentPromiseID;
- (UNDCoreDataService *)coreDataService;
- (void)correctLikeMansInAccordanceWith:(NSSet *)likeMans;
- (void)removeLikeMansFromCoreData;
- (void)savePromiseFieldIDToCoreData:(NSString *)fieldId;
- (void)notifyAboutManThatLikedPromise:(NSUInteger)userID receivePhotoURL:(NSString *)urlString;
- (void)savePhoto:(NSString *)fileName forLikeMan:(NSString *)userID;
- (void)saveData:(NSData *)data toDocumentsFile:(NSString *)filePath;

@end


@interface UNDNetworkParserTests : XCTestCase


@property (nonatomic, strong) UNDNetworkParser *parser;

@end

@implementation UNDNetworkParserTests

- (void)setUp
{
    [super setUp];
    self.parser = OCMPartialMock([UNDNetworkParser new]);
}

- (void)tearDown
{
    self.parser = nil;
    [super tearDown];
}


#pragma mark - (NSDictionary *)parseResponseFromVK:(NSData *)data

- (void)testParseResponseFromVKNilData
{
    NSDictionary *result = [self.parser parseResponseFromVK:nil];
    expect(result).to.beNil();
}

- (void)testParseResponseFromVKJSONNil
{
    id data = OCMClassMock([NSData class]);
    id jsonParser = OCMClassMock([NSJSONSerialization class]);
    OCMStub([jsonParser JSONObjectWithData:data options:0 error:nil]).andReturn(nil);
    NSDictionary *result = [self.parser parseResponseFromVK:data];
    expect(result).equal(nil);
}

- (void)testParseResponseFromVKJSONEmpty
{
    id data = OCMClassMock([NSData class]);
    id jsonParser = OCMClassMock([NSJSONSerialization class]);
    OCMStub([jsonParser JSONObjectWithData:data options:0 error:nil]).andReturn(@{});
    NSDictionary *result = [self.parser parseResponseFromVK:data];
    OCMVerify([result count]);
    expect(result).equal(nil);
}

- (void)testParseResponseFromVKErrorResponse
{
    id data = OCMClassMock([NSData class]);
    id jsonParser = OCMClassMock([NSJSONSerialization class]);
    OCMStub([jsonParser JSONObjectWithData:data options:0 error:nil]).andReturn(@{@"error":@"blabla"});
    NSDictionary *result = [self.parser parseResponseFromVK:data];
    expect(result).equal(nil);
}

- (void)testParseResponseFromVKAnyOtherResponse
{
    id data = OCMClassMock([NSData class]);
    id jsonParser = OCMClassMock([NSJSONSerialization class]);
    OCMStub([jsonParser JSONObjectWithData:data options:0 error:nil]).andReturn(@{@"blabla":@"blabla"});
    
    NSDictionary *result = [self.parser parseResponseFromVK:data];
    
    expect(result).equal(nil);
}

- (void)testParseResponseFromVKSelfValidResponse
{
    id data = OCMClassMock([NSData class]);
    id jsonParser = OCMClassMock([NSJSONSerialization class]);
    OCMStub([jsonParser JSONObjectWithData:data options:0 error:nil]).andReturn(@{@"response":@"blabla"});
    
    NSDictionary *result = [self.parser parseResponseFromVK:data];
    
    expect(result).equal(nil);
}

- (void)testParseResponseFromVKFullValidResponse
{
    id data = OCMClassMock([NSData class]);
    id jsonParser = OCMClassMock([NSJSONSerialization class]);
    OCMStub([jsonParser JSONObjectWithData:data options:0 error:nil]).andReturn(@{@"response":@{@"bla":@"bla"}});
    
    NSDictionary *result = [self.parser parseResponseFromVK:data];
    
    expect(result).equal(@{@"bla":@"bla"});
}


#pragma mark - (void)loadUsersThatLikeFieldDidFinishWithData:(NSData *)data

- (void)testLoadUsersThatLikeFieldDidFinishWithDataNilPromise
{
    id data = OCMClassMock([NSData class]);

    OCMStub([self.parser currentPromiseID]).andReturn(nil);
    
    OCMReject([self.parser removeLikeMansFromCoreData]);
    OCMReject([self.parser correctLikeMansInAccordanceWith:nil]);
    
    [self.parser loadUsersThatLikeFieldDidFinishWithData:data];
}

- (void)testLoadUsersThatLikeFieldDidFinishWithDataNILResponse
{
    id data = OCMClassMock([NSData class]);
    id promiseID = OCMClassMock([NSManagedObjectID class]);
    OCMStub([self.parser currentPromiseID]).andReturn(promiseID);
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(nil);
    
    OCMReject([self.parser removeLikeMansFromCoreData]);

    [self.parser loadUsersThatLikeFieldDidFinishWithData:data];
}

- (void)testLoadUsersThatLikeFieldDidFinishWithDataEmptyResponse
{
    id data = OCMClassMock([NSData class]);
    id promiseID = OCMClassMock([NSManagedObjectID class]);

    OCMStub([self.parser currentPromiseID]).andReturn(promiseID);
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{});
    
    OCMReject([self.parser removeLikeMansFromCoreData]);
    OCMReject([self.parser correctLikeMansInAccordanceWith:nil]);
    
    [self.parser loadUsersThatLikeFieldDidFinishWithData:data];
}

- (void)testLoadUsersThatLikeFieldDidFinishWithDataWrongResponse
{
    id data = OCMClassMock([NSData class]);
    id promiseID = OCMClassMock([NSManagedObjectID class]);

    OCMStub([self.parser currentPromiseID]).andReturn(promiseID);
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"blabla":@"blabla"});
    
    OCMReject([self.parser removeLikeMansFromCoreData]);
    OCMReject([self.parser correctLikeMansInAccordanceWith:nil]);
    
    [self.parser loadUsersThatLikeFieldDidFinishWithData:data];
}

- (void)testLoadUsersThatLikeFieldDidFinishWithDataCountCantCastToNumber
{
    id data = OCMClassMock([NSData class]);
    id promiseID = OCMClassMock([NSManagedObjectID class]);

    NSDictionary *dict = @{
                           @"count":@"bla",
                           @"items":@""
                           };
    
    OCMStub([self.parser currentPromiseID]).andReturn(promiseID);
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(dict);
    
    OCMReject([self.parser removeLikeMansFromCoreData]);
    OCMReject([self.parser correctLikeMansInAccordanceWith:nil]);
    
    [self.parser loadUsersThatLikeFieldDidFinishWithData:data];
}

- (void)testLoadUsersThatLikeFieldDidFinishWithDataCountZero
{
    id data = OCMClassMock([NSData class]);
    id promiseID = OCMClassMock([NSManagedObjectID class]);

    NSDictionary *dict = @{
                           @"count":@0,
                           @"items":@""
                           };
    
    OCMStub([self.parser currentPromiseID]).andReturn(promiseID);
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(dict);
    OCMStub([self.parser removeLikeMansFromCoreData]);
    
    OCMReject([self.parser correctLikeMansInAccordanceWith:nil]);
    
    [self.parser loadUsersThatLikeFieldDidFinishWithData:data];
    
    OCMVerify([self.parser removeLikeMansFromCoreData]);
}

- (void)testLoadUsersThatLikeFieldDidFinishWithDataBadItems
{
    id data = OCMClassMock([NSData class]);
    id promiseID = OCMClassMock([NSManagedObjectID class]);

    NSDictionary *dict = @{
                           @"count":@2,
                           @"items":@""
                           };
    
    OCMStub([self.parser currentPromiseID]).andReturn(promiseID);
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(dict);
    
    OCMReject([self.parser correctLikeMansInAccordanceWith:nil]);
    OCMReject([self.parser removeLikeMansFromCoreData]);

    [self.parser loadUsersThatLikeFieldDidFinishWithData:data];
}

- (void)testLoadUsersThatLikeFieldDidFinishWithDataNormal
{
    id data = OCMClassMock([NSData class]);
    id promiseID = OCMClassMock([NSManagedObjectID class]);

    NSDictionary *dict = @{
                           @"count":@2,
                           @"items":@[@12312,@2132342]
                           };
    
    OCMStub([self.parser currentPromiseID]).andReturn(promiseID);
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(dict);
    OCMStub([self.parser correctLikeMansInAccordanceWith:nil]);
    
    OCMReject([self.parser removeLikeMansFromCoreData]);
    
    [self.parser loadUsersThatLikeFieldDidFinishWithData:data];
    
    NSArray *array = @[@12312,@2132342];
    
    OCMVerify([self.parser correctLikeMansInAccordanceWith: [NSSet setWithArray:array]]);
}


#pragma mark - (void)loadPostPromiseOnUserWallFinishWithData:(NSData *)data

- (void)testLoadPostPromiseOnUserWallFinishWithDataJSONNil
{
    id data = OCMClassMock([NSData class]);
    
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(nil);
    OCMReject([self.parser savePromiseFieldIDToCoreData:nil]);

    [self.parser loadPostPromiseOnUserWallFinishWithData:data];
}

- (void)testLoadPostPromiseOnUserWallFinishWithDataJSONEmpty
{
    id data = OCMClassMock([NSData class]);
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{});
    
    OCMReject([self.parser savePromiseFieldIDToCoreData:@""]);
    [self.parser loadPostPromiseOnUserWallFinishWithData:data];

}

- (void)testLoadPostPromiseOnUserWallFinishWithDataPostIdContainGarbage
{
    id data = OCMClassMock([NSData class]);
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"post_id" : @"jbk"});
    
    OCMReject([self.parser savePromiseFieldIDToCoreData:@""]);
    [self.parser loadPostPromiseOnUserWallFinishWithData:data];
}

- (void)testLoadPostPromiseOnUserWallFinishWithDataNormal
{
    id data = OCMClassMock([NSData class]);
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"post_id" : @"342"});
    OCMStub([self.parser savePromiseFieldIDToCoreData:@"342"]);
    
    [self.parser loadPostPromiseOnUserWallFinishWithData:data];
    OCMVerify([self.parser savePromiseFieldIDToCoreData:@"342"]);
}


#pragma mark - (void)loadUserPhotoURLDidFinishWithData:(NSData *)data

- (void)testLoadUserPhotoURLDidFinishWithDataJSONNil
{
    id data = OCMClassMock([NSData class]);

    OCMStub([self.parser parseResponseFromVK:data]).andReturn(nil);
    OCMReject([self.parser notifyAboutManThatLikedPromise:0 receivePhotoURL:nil]);
    
    [self.parser loadUserPhotoURLDidFinishWithData:data];
}

- (void)testLoadUserPhotoURLDidFinishWithDataJSONEmpty
{
    id data = OCMClassMock([NSData class]);
    
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{});
    OCMReject([self.parser notifyAboutManThatLikedPromise:0 receivePhotoURL:nil]);
    
    [self.parser loadUserPhotoURLDidFinishWithData:data];
}

- (void)testLoadUserPhotoURLDidFinishWithDataJSONWrong
{
    id data = OCMClassMock([NSData class]);
    
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"blabla":@"blavla"});
    OCMReject([self.parser notifyAboutManThatLikedPromise:0 receivePhotoURL:nil]);
    
    [self.parser loadUserPhotoURLDidFinishWithData:data];
}

- (void)testLoadUserPhotoURLDidFinishWithDataItemsContainsGarbage
{
    id data = OCMClassMock([NSData class]);
    
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"items":@"blavla"});
    OCMReject([self.parser notifyAboutManThatLikedPromise:0 receivePhotoURL:nil]);
    
    [self.parser loadUserPhotoURLDidFinishWithData:data];
}

- (void)testLoadUserPhotoURLDidFinishWithDataEmptyArray
{
    id data = OCMClassMock([NSData class]);
    
    NSArray *array = @[];
    
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"items":array});
    OCMReject([self.parser notifyAboutManThatLikedPromise:0 receivePhotoURL:nil]);
    
    [self.parser loadUserPhotoURLDidFinishWithData:data];
}

- (void)testLoadUserPhotoURLDidFinishWithDataArrayContainGarbage
{
    id data = OCMClassMock([NSData class]);
    
    NSArray *array = @[@54];
    
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"items":array});
    OCMReject([self.parser notifyAboutManThatLikedPromise:0 receivePhotoURL:nil]);
    
    [self.parser loadUserPhotoURLDidFinishWithData:data];
}

- (void)testLoadUserPhotoURLDidFinishWithDataDictionaryContainNotAll
{
    id data = OCMClassMock([NSData class]);
    
    NSArray *array = @[@{
                           @"owner_id":@"",
                           @"bla":@"bla"
                           }];
    
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"items":array});
    OCMReject([self.parser notifyAboutManThatLikedPromise:0 receivePhotoURL:nil]);
    
    [self.parser loadUserPhotoURLDidFinishWithData:data];
}

- (void)testLoadUserPhotoURLDidFinishWithDataOwnerIdNotNumber
{
    id data = OCMClassMock([NSData class]);
    
    NSArray *array = @[@{
                           @"owner_id":@"bla",
                           @"photo_75":@"bla"
                           }];
    
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"items":array});
    OCMReject([self.parser notifyAboutManThatLikedPromise:0 receivePhotoURL:nil]);
    
    [self.parser loadUserPhotoURLDidFinishWithData:data];
}

- (void)testLoadUserPhotoURLDidFinishWithDataPhotoEmpty
{
    id data = OCMClassMock([NSData class]);
    
    NSArray *array = @[@{
                           @"owner_id":@6535376,
                           @"photo_75":@""
                           }];
    
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"items":array});
    OCMReject([self.parser notifyAboutManThatLikedPromise:6535376 receivePhotoURL:nil]);
    
    [self.parser loadUserPhotoURLDidFinishWithData:data];
}

- (void)testLoadUserPhotoURLDidFinishWithDataNotifyVerify
{
    id data = OCMClassMock([NSData class]);
    
    NSArray *array = @[@{
                           @"owner_id":@6535376,
                           @"photo_75":@"edfgsdf.jpg"
                           }];
    
    OCMStub([self.parser parseResponseFromVK:data]).andReturn(@{@"items":array});
    OCMStub([self.parser notifyAboutManThatLikedPromise:6535376 receivePhotoURL:@""]);
    
    [self.parser loadUserPhotoURLDidFinishWithData:data];
    
    OCMVerify([self.parser notifyAboutManThatLikedPromise:6535376 receivePhotoURL:@"edfgsdf.jpg"]);
}


#pragma mark - (void)loadPhotoDidFinishWithData:(NSData *)data taskDescription:(NSString *)description

- (void)testLoadPhotoDidFinishWithDataTaskDescriptionDataNil
{    
    OCMReject([self.parser savePhoto:@"" forLikeMan:@""]);
    
    [self.parser loadPhotoDidFinishWithData:nil taskDescription:@"lklkb"];
}

- (void)testLoadPhotoDidFinishWithDataTaskDescriptionDescriptionNil
{
    id data = OCMClassMock([NSData class]);
    
    OCMReject([self.parser savePhoto:@"" forLikeMan:@""]);
    
    [self.parser loadPhotoDidFinishWithData:data taskDescription:nil];
}

- (void)testLoadPhotoDidFinishWithDataTaskDescriptionDescriptionNotContainSharp
{
    id data = OCMClassMock([NSData class]);
    
    OCMReject([self.parser savePhoto:@"" forLikeMan:@""]);
    
    [self.parser loadPhotoDidFinishWithData:data taskDescription:@"blabla123124"];
}

- (void)testLoadPhotoDidFinishWithDataTaskDescriptionUserIDNotNumeric
{
    id data = OCMClassMock([NSData class]);
    
    OCMReject([self.parser savePhoto:@"kjgkgj" forLikeMan:@""]);
    
    [self.parser loadPhotoDidFinishWithData:data taskDescription:@"blabla#kjgkgj"];
}

- (void)testLoadPhotoDidFinishWithDataTaskDescriptionNormal
{
    id data = OCMClassMock([NSData class]);
    id stringConstant = OCMClassMock([UNDStringConstants class]);

    OCMStub([stringConstant getPhotoStringTemplate]).andReturn(@"/%@.jpg");
    OCMStub([stringConstant getDocumentDirPath]).andReturn(@"blabla");
    OCMStub([self.parser saveData:data toDocumentsFile:@"blabla/123456"]);
    OCMStub([self.parser savePhoto:@"/123456.jpg" forLikeMan:@"123456"]);
    
    [self.parser loadPhotoDidFinishWithData:data taskDescription:@"blabla#123456"];
    
    OCMVerify([self.parser saveData:data toDocumentsFile:@"blabla/123456.jpg"]);
    OCMVerify([self.parser savePhoto:@"/123456.jpg" forLikeMan:@"123456"]);

}

@end
