//
// Created by azu on 2014/09/08.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

// fetch all -> filter by predicate
@interface RequestInMemory : NSObject
@property(nonatomic, strong) NSArray *fetchedContents;

// initialize class + fetch data from CoreData
+ (instancetype)memoryEntityDescription:(NSEntityDescription *) entityDescription context:(NSManagedObjectContext *) managedObjectContext;

+ (instancetype)memoryEntityDescription:(NSEntityDescription *) entityDescription predicate:(NSPredicate *) predicate context:(NSManagedObjectContext *) managedObjectContext;

#pragma mark - manually


// manually update internal database
// when initialize the class, automatically call this method.
- (NSArray *)fetchAll;

- (NSArray *)fetchWithPredicate:(NSPredicate *) predicate;

#pragma mark - filter helper

- (BOOL)testWithPredicate:(NSPredicate *) predicate;

- (NSArray *)findFirstWithPredicate:(NSPredicate *) predicate;

- (NSArray *)findAllWithPredicate:(NSPredicate *) predicate;

@end