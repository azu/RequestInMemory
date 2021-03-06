//
// Created by azu on 2014/09/08.
//

#import "RequestInMemory.h"


@interface RequestInMemory ()
@property(nonatomic, strong) NSEntityDescription *targetEntityDescription;
@property(nonatomic, strong) NSManagedObjectContext *managedContext;
@property(nonatomic, strong) NSArray *fetchedContents;
@end

@implementation RequestInMemory {

}
+ (instancetype)memoryEntityDescription:(NSEntityDescription *) entityDescription context:(NSManagedObjectContext *) managedObjectContext {
    RequestInMemory *fetchRequestMemory = [[self alloc] init];
    fetchRequestMemory.targetEntityDescription = entityDescription;
    fetchRequestMemory.managedContext = managedObjectContext;
    fetchRequestMemory.fetchedContents = [fetchRequestMemory fetchAll];
    return fetchRequestMemory;
}

+ (instancetype)memoryEntityDescription:(NSEntityDescription *) entityDescription predicate:(NSPredicate *) predicate context:(NSManagedObjectContext *) managedObjectContext {
    RequestInMemory *fetchRequestMemory = [[self alloc] init];
    fetchRequestMemory.targetEntityDescription = entityDescription;
    fetchRequestMemory.managedContext = managedObjectContext;
    fetchRequestMemory.fetchedContents = [fetchRequestMemory fetchWithPredicate:predicate];
    return fetchRequestMemory;
}

- (NSArray *)fetchAll {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:self.targetEntityDescription.name];
    NSError *error = nil;
    NSArray *results = [self.managedContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"fetchAll: Error = %@", error);
    }
    return results;
}

- (NSArray *)fetchWithPredicate:(NSPredicate *) predicate {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:self.targetEntityDescription.name];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [self.managedContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"fetchWithPredicate: Error = %@", error);
    }
    return results;
}

- (BOOL)testWithPredicate:(NSPredicate *) predicate {
    NSArray *results = [self.fetchedContents filteredArrayUsingPredicate:predicate];
    return results.count > 0;
}

- (NSArray *)findWithAllPredicate:(NSPredicate *) predicate {
    return [self.fetchedContents filteredArrayUsingPredicate:predicate];
}

- (NSArray *)findWithFirstPredicate:(NSPredicate *) predicate {
    NSArray *array = [self.fetchedContents filteredArrayUsingPredicate:predicate];
    if (array.count > 0) {
        return [array firstObject];
    } else {
        return nil;
    }
}
@end