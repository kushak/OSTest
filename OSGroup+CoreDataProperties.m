//
//  OSGroup+CoreDataProperties.m
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "OSGroup+CoreDataProperties.h"

@implementation OSGroup (CoreDataProperties)

+ (NSFetchRequest<OSGroup *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"OSGroup"];
}

@dynamic name;
@dynamic students;

@end
