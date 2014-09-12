# RequestInMemory

[![CI Status](http://img.shields.io/travis/azu/RequestInMemory.svg?style=flat)](https://travis-ci.org/azu/RequestInMemory)
[![Version](https://img.shields.io/cocoapods/v/RequestInMemory.svg?style=flat)](http://cocoadocs.org/docsets/RequestInMemory)
[![License](https://img.shields.io/cocoapods/l/RequestInMemory.svg?style=flat)](http://cocoadocs.org/docsets/RequestInMemory)
[![Platform](https://img.shields.io/cocoapods/p/RequestInMemory.svg?style=flat)](http://cocoadocs.org/docsets/RequestInMemory)

Once a fetch, does query request as many times as you wants.

## Installation

RequestInMemory is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "RequestInMemory"

## Usage

```objc
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
```

### Background

First `RequestInMemory` fetch ALL data only once.

You can does query request without having to access the CoreData next time.

### Bench

You try to `pod try RequestInMemory`


```objc
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
    [self.personInMemory findFirstPredicate:predicate];
}

- (void)performCoreData {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", @"age", 10];
    [Person MR_findFirstWithPredicate:predicate];
}
```

Result:

```
Total Runtime performCoreData: 1.53506 s
Total Runtime performRequestInMemory: 0.956278 s
```

### Caution

`RequestInMemory` fetch ALL data.  In other words, `RequestInMemory` is memory-hogging.

## Requirements

- CoreData

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

MIT