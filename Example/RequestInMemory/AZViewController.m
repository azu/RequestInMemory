//
//  AZViewController.m
//  RequestInMemory
//
//  Created by azu on 09/10/2014.
//  Copyright (c) 2014 azu. All rights reserved.
//

#import "AZViewController.h"
#import "Person.h"
#import "NSManagedObject+MagicalRecord.h"
#import "AKUNumberGenerator.h"
#import "RequestInMemory.h"
#import "AKUStringGenerator.h"
#import "NSManagedObject+MagicalFinders.h"
#import "NSManagedObjectContext+MagicalRecord.h"

extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

@interface AZViewController ()

@property(nonatomic, strong) RequestInMemory *personInMemory;
@end

@implementation AZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeCoreData];
}

- (void)initializeCoreData {
    for (NSInteger i = 0; i <= 1000; i++) {
        Person *person = [Person MR_createEntity];
        person.name = [AKUStringGenerator alphabetWithRange:NSMakeRange(6, 12)];
        person.age = @([AKUNumberGenerator between:0 end:100]);
    }
}

- (void)viewDidAppear:(BOOL) animated {
    [super viewDidAppear:animated];
    CFTimeInterval startTime = CACurrentMediaTime();
    {
        for (size_t i = 0; i < 1000; i++) {
            @autoreleasepool {
                [self performCoreData];
            }
        }
    }
    CFTimeInterval endTime = CACurrentMediaTime();
    NSLog(@"Total Runtime performCoreData: %g s", endTime - startTime);
    CFTimeInterval startTime_b = CACurrentMediaTime();
    {
        self.personInMemory = [RequestInMemory memoryEntityDescription:[Person MR_entityDescription] context:[NSManagedObjectContext MR_defaultContext]];
        for (size_t i = 0; i < 1000; i++) {
            @autoreleasepool {
                [self performRequestInMemory];
            }
        }
    }
    CFTimeInterval endTime_b = CACurrentMediaTime();
    NSLog(@"Total Runtime performRequestInMemory: %g s", endTime_b - startTime_b);
}

- (void)performRequestInMemory {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", @"age", 10];
    [self.personInMemory findFirstWithPredicate:predicate];
}

- (void)performCoreData {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", @"age", 10];
    [Person MR_findFirstWithPredicate:predicate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
