//
//  OSStudent+CoreDataProperties.m
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "OSStudent+CoreDataProperties.h"

@implementation OSStudent (CoreDataProperties)

+ (NSFetchRequest<OSStudent *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"OSStudent"];
}

@dynamic birthDay;
@dynamic fullName;
@dynamic photo;
@dynamic group;

@end
