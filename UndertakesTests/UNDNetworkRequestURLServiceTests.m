//
//  UNDNetworkRequestURLServiceTests.m
//  UndertakesTests
//
//  Created by Павел Пичкуров on 17.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UNDNetworkRequestURLService.h"
#import "UNDStringConstants.h"
#import "Expecta.h"
#import "OCMock.h"


@interface UNDNetworkRequestURLServiceTests : XCTestCase


@end

@implementation UNDNetworkRequestURLServiceTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - + (NSURL *)getUserPhotoRequestURL:(NSUInteger)userID

- (void)testGetUserPhotoRequestURLHaveToken
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(@"TOKEN");
    
    NSURL *url = [UNDNetworkRequestURLService getUserPhotoRequestURL:0];
    
    expect(url).to.equal([NSURL URLWithString:@"https://api.vk.com/method/photos.get?owner_id=0&album_id=profile&rev=1&extended=0&photo_sizes=0&count=1&v=5.71&access_token=TOKEN"]);
}

- (void)testGetUserPhotoRequestURLHaveNoToken
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(nil);
    
    NSURL *url = [UNDNetworkRequestURLService getUserPhotoRequestURL:0];
    
    expect(url).to.beNil();
}


#pragma mark - + (NSURL *)getCreatePromiseOnTheUserWallRequestURL:(NSString *)title fulltext:(NSString *)fullText

- (void)testGetCreatePromiseOnTheUserWallRequestURLfulltextNilFull
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(nil);
    OCMStub([stringConstantClass getUserID]).andReturn(nil);

    
    NSURL *url = [UNDNetworkRequestURLService getCreatePromiseOnTheUserWallRequestURL:@"asda" fulltext:nil];
    
    expect(url).to.beNil();
}

- (void)testGetCreatePromiseOnTheUserWallRequestURLfulltextNiltitle
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(nil);
    OCMStub([stringConstantClass getUserID]).andReturn(nil);
    
    
    NSURL *url = [UNDNetworkRequestURLService getCreatePromiseOnTheUserWallRequestURL:nil fulltext:@"asd"];
    
    expect(url).to.beNil();
}

- (void)testGetCreatePromiseOnTheUserWallRequestURLfulltextEmptyTitle
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(nil);
    OCMStub([stringConstantClass getUserID]).andReturn(nil);
    
    
    NSURL *url = [UNDNetworkRequestURLService getCreatePromiseOnTheUserWallRequestURL:@"" fulltext:@"asda"];
    
    expect(url).to.beNil();
}

- (void)testGetCreatePromiseOnTheUserWallRequestURLfulltextEmpryFull
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(nil);
    OCMStub([stringConstantClass getUserID]).andReturn(nil);
    
    NSURL *url = [UNDNetworkRequestURLService getCreatePromiseOnTheUserWallRequestURL:@"asda" fulltext:@""];
    
    expect(url).to.beNil();
}

- (void)testGetCreatePromiseOnTheUserWallRequestURLfulltextNoUserID
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(nil);
    OCMStub([stringConstantClass getUserID]).andReturn(nil);
    
    NSURL *url = [UNDNetworkRequestURLService getCreatePromiseOnTheUserWallRequestURL:@"asda" fulltext:@"asda"];
    
    expect(url).to.beNil();
}

- (void)testGetCreatePromiseOnTheUserWallRequestURLfulltextNoToken
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(nil);
    OCMStub([stringConstantClass getUserID]).andReturn(@"232");
    
    NSURL *url = [UNDNetworkRequestURLService getCreatePromiseOnTheUserWallRequestURL:@"asda" fulltext:@"asda"];
    
    expect(url).to.beNil();
}

- (void)testGetCreatePromiseOnTheUserWallRequestURLfulltextNormal
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(@"TOKEN");
    OCMStub([stringConstantClass getUserID]).andReturn(@"232");
    
    NSURL *url = [UNDNetworkRequestURLService getCreatePromiseOnTheUserWallRequestURL:@"asda" fulltext:@"asda"];
    
    expect(url).toNot.beNil();
}


#pragma mark - + (NSURL *)getUsersLikeFieldRequestURL:(NSUInteger)fieldID

- (void)testGetUsersLikeFieldRequestURLNilUserID
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(@"token");
    OCMStub([stringConstantClass getUserID]).andReturn(nil);
    
    NSURL *url = [UNDNetworkRequestURLService getUsersLikeFieldRequestURL:0];
    
    expect(url).to.beNil();
}

- (void)testGetUsersLikeFieldRequestURLNilToken
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(nil);
    OCMStub([stringConstantClass getUserID]).andReturn(@"1231231");
    
    NSURL *url = [UNDNetworkRequestURLService getUsersLikeFieldRequestURL:0];
    
    expect(url).to.beNil();
}

- (void)testGetUsersLikeFieldRequestURLNormal
{
    id stringConstantClass = OCMClassMock([UNDStringConstants class]);
    OCMStub([stringConstantClass getToken]).andReturn(@"sdas");
    OCMStub([stringConstantClass getUserID]).andReturn(@"23343");
    
    NSURL *url = [UNDNetworkRequestURLService getUsersLikeFieldRequestURL:0];
    
    expect(url).toNot.beNil();
}

@end
