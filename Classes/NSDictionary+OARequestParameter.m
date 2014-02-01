//
//  NSDictionary+OAParameter.m
//  QROAuth
//
//  Created by Taro Kobayashi on 27/01/2014.
//  Copyright (c) 2014 Taro Kobayashi. All rights reserved.
//

#import "OARequestParameter.h"
#import "NSDictionary+OARequestParameter.h"

@implementation NSDictionary (OAParameter)
- (NSArray*) cast
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity: [self count]];
    
    for (id key in self)
    {
        [array addObject:[[OARequestParameter alloc]
                          initWithName:key
                          value:[self valueForKey:key]]];
    }
    
    return array;
}
@end
