//
//  OSStudent+CoreDataProperties.h
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "OSStudent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OSStudent (CoreDataProperties)

+ (NSFetchRequest<OSStudent *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *birthDay;
@property (nullable, nonatomic, copy) NSString *fullName;
@property (nullable, nonatomic, retain) NSData *photo;
@property (nullable, nonatomic, retain) OSGroup *group;

@end

NS_ASSUME_NONNULL_END
