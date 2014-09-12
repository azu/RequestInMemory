//
//  Person.h
//  RequestInMemory
//
//  Created by azu on 2014/09/12.
//  Copyright (c) 2014年 azu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;

@end
