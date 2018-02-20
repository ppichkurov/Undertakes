//
//  UNDCoreDataServiceTests.m
//  UndertakesTests
//
//  Created by Павел Пичкуров on 17.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Expecta.h"
#import "OCMock.h"
#import "UNDCoreDataService.h"


@interface UNDCoreDataService(Tests)


- (void)removeLikeMans:(NSSet<NSNumber *> *)likeMans forPromise:(UNDPromise *)promise;
- (void)saveAllLikeMans:(NSSet<NSNumber *> *)likeMans forPromise:(UNDPromise *)promise;
- (void)removeAllLikeMansForPromise:(UNDPromise *)promise;

@end


@interface UNDCoreDataServiceTests : XCTestCase


@property (nonatomic, strong) UNDCoreDataService *coreDataService;
@property (nonatomic, strong) id entityDescriptionClass;
@property (nonatomic, strong) id requestServiceClass;
@property (nonatomic, strong) id promise;
@property (nonatomic, strong) id promiseWeb;
@property (nonatomic, strong) id likeMans;
@property (nonatomic, strong) id context;
@property (nonatomic, strong) id managedObjectID;

@end


@implementation UNDCoreDataServiceTests

- (void)setUp
{
    [super setUp];
    self.coreDataService = OCMPartialMock([UNDCoreDataService new]);
    self.entityDescriptionClass = OCMClassMock([NSEntityDescription class]);
    self.requestServiceClass = OCMClassMock([UNDCoreDataRequestService class]);
    self.promise = OCMClassMock([UNDPromise class]);
    self.promiseWeb = OCMClassMock([UNDPromiseWeb class]);
    self.context = OCMClassMock([NSManagedObjectContext class]);
    self.managedObjectID = OCMClassMock([NSManagedObjectID class]);
    self.likeMans = OCMClassMock([UNDLikeMan class]);
}

- (void)tearDown
{
    self.coreDataService = nil;
    self.entityDescriptionClass = nil;
    self.requestServiceClass = nil;
    self.promise = nil;
    self.promiseWeb = nil;
    self.context = nil;
    self.likeMans = nil;
    [super tearDown];
}


#pragma mark - (void)savePromiseToCoreDataWithTitle:(NSString *)title

- (void)testSavePromiseToCoreDataWithTitleNilTitle
{
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    
    OCMReject([self.entityDescriptionClass insertNewObjectForEntityForName:@"UNDPromise"
                                               inManagedObjectContext:self.context]).andReturn(self.promise);
    
    [self.coreDataService savePromiseToCoreDataWithTitle:nil description:@"sdfsd" importance:2 fireDate:[NSDate date]];
}

- (void)testSavePromiseToCoreDataWithTitleEmptyTitle
{
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    
    OCMReject([self.entityDescriptionClass insertNewObjectForEntityForName:@"UNDPromise"
                                                    inManagedObjectContext:self.context]).andReturn(self.promise);
    
    [self.coreDataService savePromiseToCoreDataWithTitle:@"" description:@"sdfsd" importance:2 fireDate:[NSDate date]];
}

- (void)testSavePromiseToCoreDataWithTitleNilDescr
{
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    
    OCMReject([self.entityDescriptionClass insertNewObjectForEntityForName:@"UNDPromise"
                                                    inManagedObjectContext:self.context]).andReturn(self.promise);
    
    [self.coreDataService savePromiseToCoreDataWithTitle:@"sdfs" description:nil importance:2 fireDate:[NSDate date]];
}

- (void)testSavePromiseToCoreDataWithTitleEmptyDescr
{
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    
    OCMReject([self.entityDescriptionClass insertNewObjectForEntityForName:@"UNDPromise"
                                                    inManagedObjectContext:self.context]).andReturn(self.promise);
    
    [self.coreDataService savePromiseToCoreDataWithTitle:@"sdfs" description:@"" importance:2 fireDate:[NSDate date]];
}

- (void)testSavePromiseToCoreDataWithTitleNilDate
{
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    
    OCMReject([self.entityDescriptionClass insertNewObjectForEntityForName:@"UNDPromise"
                                                    inManagedObjectContext:self.context]).andReturn(self.promise);
    
    [self.coreDataService savePromiseToCoreDataWithTitle:@"sdfs" description:@"khklh" importance:2 fireDate:nil];
}

- (void)testSavePromiseToCoreDataWithTitleNormal
{
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    
    OCMStub([self.entityDescriptionClass insertNewObjectForEntityForName:@"UNDPromise"
                                                    inManagedObjectContext:self.context]).andReturn(self.promise);
    OCMStub([[self.promise managedObjectContext] save: nil]);
    
    [self.coreDataService savePromiseToCoreDataWithTitle:@"dfdf" description:@"sdfsd" importance:2 fireDate:[NSDate date]];
    
    OCMVerify([[self.promise managedObjectContext] save: nil]);
}


#pragma mark - (void)savePromiseFieldIdToCoreData:(int64_t)fieldId;

- (void)testSavePromiseFieldIdToCoreDataNilEntity
{
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    
    OCMStub([self.entityDescriptionClass insertNewObjectForEntityForName:@"UNDPromiseWeb"
                                                  inManagedObjectContext:self.context]).andReturn(nil);
    
    OCMReject([self.coreDataService getPromisesForCurrentUser: YES]);
    
    [self.coreDataService savePromiseFieldIdToCoreData:232323];
}

- (void)testSavePromiseFieldIdToCoreDataNormal
{
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    
    OCMStub([self.entityDescriptionClass insertNewObjectForEntityForName:@"UNDPromiseWeb"
                                                  inManagedObjectContext:self.context]).andReturn(self.promiseWeb);
    
    NSArray<UNDPromise *> *array = @[self.promise];
    
    OCMStub([self.coreDataService getPromisesForCurrentUser: YES]).andReturn(array);
    
    OCMStub([[self.promiseWeb managedObjectContext] save: nil]);

    [self.coreDataService savePromiseFieldIdToCoreData:232323];
    
    OCMVerify([[self.promiseWeb managedObjectContext] save: nil]);

}


#pragma mark - (void)correctLikeManIDs:(NSSet *)likeMans forPromise:(NSManagedObjectID *)promiseID;

- (void)testCorrectLikeManIDsForPromiseNilPromiseID
{
    NSSet *set = [NSSet setWithArray:@[@2312,@1312]];
    
    OCMReject([self.requestServiceClass coreDataContext]);
    
    [self.coreDataService correctLikeManIDs:set forPromise:nil];
}

- (void)testCorrectLikeManIDsForPromiseNilPromise
{
//    NSSet *set = [NSSet setWithArray:@[@2312,@1312]];
    
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    OCMStub([self.context existingObjectWithID:self.managedObjectID error:nil]).andReturn(nil);

    OCMReject([self.coreDataService removeAllLikeMansForPromise:nil]);
    
    [self.coreDataService correctLikeManIDs:nil forPromise:self.managedObjectID];
}

- (void)testCorrectLikeManIDsForPromiseNilPromiseWeb
{
    //    NSSet *set = [NSSet setWithArray:@[@2312,@1312]];
    
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    OCMStub([self.context existingObjectWithID:self.managedObjectID error:nil]).andReturn(self.promise);
    OCMStub([self.promise webVersion]).andReturn(nil);
    
    OCMReject([self.coreDataService removeAllLikeMansForPromise:nil]);
    
    [self.coreDataService correctLikeManIDs:nil forPromise:self.managedObjectID];
}

- (void)testCorrectLikeManIDsForPromiseNilLikeMan
{
//        NSSet *set = [NSSet setWithArray:@[@2312,@1312]];
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    OCMStub([self.context existingObjectWithID:self.managedObjectID error:nil]).andReturn(self.promise);
    OCMStub([self.promise webVersion]).andReturn(self.promiseWeb);
    OCMStub([self.coreDataService removeAllLikeMansForPromise:self.promise]);
    
    [self.coreDataService correctLikeManIDs:nil forPromise:self.managedObjectID];
    
    OCMVerify([self.coreDataService removeAllLikeMansForPromise:self.promise]);
}

- (void)testCorrectLikeManIDsForPromiseEmptyBase
{
    NSSet *set = [NSSet setWithArray:@[@2312,@1312]];
    NSSet *emptySet = [NSSet set];
    
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    OCMStub([self.context existingObjectWithID:self.managedObjectID error:nil]).andReturn(self.promise);
    OCMStub([self.promise webVersion]).andReturn(self.promiseWeb);
    OCMStub([self.promiseWeb likeMans]).andReturn(emptySet);
    OCMStub([self.coreDataService saveAllLikeMans:set forPromise:self.promise]);

    OCMReject([self.coreDataService removeAllLikeMansForPromise:self.promise]);
    
    [self.coreDataService correctLikeManIDs:set forPromise:self.managedObjectID];
    
    OCMVerify([self.coreDataService saveAllLikeMans:set forPromise:self.promise]);
}

- (void)testCorrectLikeManIDsForPromiseLikesNeedToAdd
{
    NSArray *setArray = @[@2312,@1312,@76676,@6765];
    NSSet *set = OCMPartialMock([NSSet setWithArray:setArray]); // то что пришло в метод
    NSMutableSet *weNeedToAddMutableSet = OCMPartialMock([set mutableCopy]); // мутабельная копия для weNeedToAddMutableSet
    
    id resultSet = OCMClassMock([NSSet class]);
    id mutableSetClass = OCMClassMock([NSMutableSet class]);
    
    
    id promiseOne = OCMClassMock([UNDLikeMan class]);
    id promiseTwo = OCMClassMock([UNDLikeMan class]);
    NSString *oneVkID = OCMClassMock([NSString class]);
    NSString *twoVkID = OCMClassMock([NSString class]);
    OCMStub([promiseOne vkID]).andReturn(oneVkID);
    OCMStub([promiseTwo vkID]).andReturn(twoVkID);
    OCMStub([oneVkID intValue]).andReturn(2312);
    OCMStub([twoVkID intValue]).andReturn(1312);
    NSSet<UNDLikeMan *> *baseSet = [NSSet setWithArray:@[promiseOne,promiseTwo]]; // лежит в кордате
    
    
    NSMutableSet *manIdSet = OCMPartialMock([NSMutableSet setWithCapacity:baseSet.count]); // ид тех кто лежит в базе
    
    
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    OCMStub([self.context existingObjectWithID:self.managedObjectID error:nil]).andReturn(self.promise);
    OCMStub([self.promise webVersion]).andReturn(self.promiseWeb);
    OCMStub([self.promiseWeb likeMans]).andReturn(baseSet);
    
    OCMStub([mutableSetClass setWithCapacity: baseSet.count]).andReturn(manIdSet);
    
    OCMStub([set mutableCopy]).andReturn(weNeedToAddMutableSet);
    
    OCMStub([weNeedToAddMutableSet copy]).andReturn(resultSet);
    
    OCMReject([self.coreDataService removeAllLikeMansForPromise:self.promise]);
    OCMReject([self.coreDataService saveAllLikeMans:set forPromise:self.promise]);
    OCMReject([self.coreDataService removeLikeMans:[OCMArg any] forPromise:self.promise]);
    
    OCMStub([self.coreDataService saveAllLikeMans:resultSet forPromise:self.promise]);
    
    [self.coreDataService correctLikeManIDs:set forPromise:self.managedObjectID];
    
    OCMVerify([self.coreDataService saveAllLikeMans:resultSet forPromise:self.promise]);
}

- (void)testCorrectLikeManIDsForPromiseLikesNeedToDelete
{
    NSArray *setArray = @[@2312];
    NSSet *set = OCMPartialMock([NSSet setWithArray:setArray]); // то что пришло в метод
    NSMutableSet *weNeedToAddMutableSet = OCMPartialMock([set mutableCopy]); // мутабельная копия для weNeedToAddMutableSet
    
    id resultSet = OCMClassMock([NSSet class]);
    id mutableSetClass = OCMClassMock([NSMutableSet class]);

    
    id promiseOne = OCMClassMock([UNDLikeMan class]);
    id promiseTwo = OCMClassMock([UNDLikeMan class]);
    NSString *oneVkID = OCMClassMock([NSString class]);
    NSString *twoVkID = OCMClassMock([NSString class]);
    OCMStub([promiseOne vkID]).andReturn(oneVkID);
    OCMStub([promiseTwo vkID]).andReturn(twoVkID);
    OCMStub([oneVkID intValue]).andReturn(2312);
    OCMStub([twoVkID intValue]).andReturn(1312);
    NSSet<UNDLikeMan *> *baseSet = [NSSet setWithArray:@[promiseOne,promiseTwo]]; // лежит в кордате
    
    
    NSMutableSet *manIdSet = OCMPartialMock([NSMutableSet setWithCapacity:baseSet.count]); // ид тех кто лежит в базе

    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    OCMStub([self.context existingObjectWithID:self.managedObjectID error:nil]).andReturn(self.promise);
    OCMStub([self.promise webVersion]).andReturn(self.promiseWeb);
    OCMStub([self.promiseWeb likeMans]).andReturn(baseSet);
    OCMStub([mutableSetClass setWithCapacity: baseSet.count]).andReturn(manIdSet);
    OCMStub([set mutableCopy]).andReturn(weNeedToAddMutableSet);
    OCMStub([weNeedToAddMutableSet copy]).andReturn(resultSet);
    OCMStub([self.coreDataService removeLikeMans:[OCMArg any] forPromise:self.promise]);

    OCMReject([self.coreDataService removeAllLikeMansForPromise:self.promise]);
    OCMReject([self.coreDataService saveAllLikeMans:[OCMArg any] forPromise:self.promise]);

//    OCMStub([self.coreDataService saveAllLikeMans:resultSet forPromise:self.promise]);
    
    [self.coreDataService correctLikeManIDs:set forPromise:self.managedObjectID];
   
    OCMVerify([self.coreDataService removeLikeMans:[OCMArg any] forPromise:self.promise]);

}

- (void)testCorrectLikeManIDsForPromiseLikesNeedToAddAndDelete
{
    NSArray *setArray = @[@2312,@76676,@6765];
    NSSet *set = OCMPartialMock([NSSet setWithArray:setArray]); // то что пришло в метод
    NSMutableSet *weNeedToAddMutableSet = OCMPartialMock([set mutableCopy]); // мутабельная копия для weNeedToAddMutableSet
    
    id resultSet = OCMClassMock([NSSet class]);
    id mutableSetClass = OCMClassMock([NSMutableSet class]);
    
    
    id promiseOne = OCMClassMock([UNDLikeMan class]);
    id promiseTwo = OCMClassMock([UNDLikeMan class]);
    NSString *oneVkID = OCMClassMock([NSString class]);
    NSString *twoVkID = OCMClassMock([NSString class]);
    OCMStub([promiseOne vkID]).andReturn(oneVkID);
    OCMStub([promiseTwo vkID]).andReturn(twoVkID);
    OCMStub([oneVkID intValue]).andReturn(2312);
    OCMStub([twoVkID intValue]).andReturn(1312);
    NSSet<UNDLikeMan *> *baseSet = [NSSet setWithArray:@[promiseOne,promiseTwo]]; // лежит в кордате
    
    
    NSMutableSet *manIdSet = OCMPartialMock([NSMutableSet setWithCapacity:baseSet.count]); // ид тех кто лежит в базе
    
    
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    OCMStub([self.context existingObjectWithID:self.managedObjectID error:nil]).andReturn(self.promise);
    OCMStub([self.promise webVersion]).andReturn(self.promiseWeb);
    OCMStub([self.promiseWeb likeMans]).andReturn(baseSet);
    
    OCMStub([mutableSetClass setWithCapacity: baseSet.count]).andReturn(manIdSet);
    
    OCMStub([set mutableCopy]).andReturn(weNeedToAddMutableSet);
    
    OCMStub([weNeedToAddMutableSet copy]).andReturn(resultSet);
    
    OCMStub([self.coreDataService removeLikeMans:[OCMArg any] forPromise:self.promise]);
    OCMStub([self.coreDataService saveAllLikeMans:resultSet forPromise:self.promise]);
    
    OCMReject([self.coreDataService removeAllLikeMansForPromise:self.promise]);
    OCMReject([self.coreDataService saveAllLikeMans:set forPromise:self.promise]);
   
    [self.coreDataService correctLikeManIDs:set forPromise:self.managedObjectID];
    
    OCMVerify([self.coreDataService saveAllLikeMans:resultSet forPromise:self.promise]);
    OCMVerify([self.coreDataService removeLikeMans:[OCMArg any] forPromise:self.promise]);
}


#pragma mark - (void)correctLikeManID:(NSString *)likeManID photo:(NSString *)photoPath;

- (void)testCorrectLikeManIDPhotoLikeManNil
{
    [self.coreDataService correctLikeManID:nil photo:@"asdasd"];
    
    OCMReject([[self.requestServiceClass coreDataContext] save:nil]);
}

- (void)testCorrectLikeManIDPhotoLikeManEmpty
{
    [self.coreDataService correctLikeManID:@"" photo:@"asdasd"];
    
    OCMReject([[self.requestServiceClass coreDataContext] save:nil]);
}

- (void)testCorrectLikeManIDPhotoPhotoNil
{
    [self.coreDataService correctLikeManID:@"sdas" photo:nil];
    
    OCMReject([[self.requestServiceClass coreDataContext] save:nil]);
}

- (void)testCorrectLikeManIDPhotoPhotoEmpty
{
    [self.coreDataService correctLikeManID:@"sda" photo:@""];
    
    OCMReject([[self.requestServiceClass coreDataContext] save:nil]);
}

- (void)testCorrectLikeManIDPhotoOurLikeMansNil
{
    id fetchRequest = OCMClassMock([NSFetchRequest class]);
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    OCMStub([self.requestServiceClass promiseLikeManRequest:@"sda"]).andReturn(fetchRequest);
    OCMStub([self.context executeFetchRequest:fetchRequest error:nil]).andReturn(nil);
    
    [self.coreDataService correctLikeManID:@"sda" photo:@"asda"];

    
    OCMReject([self.context save:nil]);
}

- (void)testCorrectLikeManIDPhotoNormal
{
    NSArray<UNDLikeMan *> *arrayLikeMans = @[self.likeMans];
    id fetchRequest = OCMClassMock([NSFetchRequest class]);
    OCMStub([self.requestServiceClass coreDataContext]).andReturn(self.context);
    OCMStub([self.requestServiceClass promiseLikeManRequest:@"sda"]).andReturn(fetchRequest);
    OCMStub([self.context executeFetchRequest:fetchRequest error:nil]).andReturn(arrayLikeMans);
    
    OCMStub([self.context save:nil]);
    
    [self.coreDataService correctLikeManID:@"sda" photo:@"asda"];
    
    OCMVerify([self.context save:nil]);
}

@end
