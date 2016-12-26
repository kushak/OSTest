//
//  OSGroup+CoreDataProperties.h
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "OSGroup+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OSGroup (CoreDataProperties)

+ (NSFetchRequest<OSGroup *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<OSStudent *> *students;

@end

@interface OSGroup (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(OSStudent *)value;
- (void)removeStudentsObject:(OSStudent *)value;
- (void)addStudents:(NSSet<OSStudent *> *)values;
- (void)removeStudents:(NSSet<OSStudent *> *)values;

@end

NS_ASSUME_NONNULL_END
