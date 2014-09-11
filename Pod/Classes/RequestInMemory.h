//
// Created by azu on 2014/09/08.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

// fetch all -> filter by predicate
@interface RequestInMemory : NSObject
// initialize class + fetch data from CoreData
+ (instancetype)memoryEntityDescription:(NSEntityDescription *) entityDescription context:(NSManagedObjectContext *) managedObjectContext;

#pragma mark - manually

// manually update internal database
// when initialize the class, automatically call this method.
- (NSArray *)fetchAll;

#pragma mark - filter helper

- (BOOL)testPredicate:(NSPredicate *) predicate;

- (NSArray *)findFirstPredicate:(NSPredicate *) predicate;

- (NSArray *)findAllPredicate:(NSPredicate *) predicate;

@end