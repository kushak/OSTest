//
//  OSDataManager.h
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OSGroup;
@class OSStudent;

@interface OSDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

+(OSDataManager*) sharedManager;

-(void) addGroup: (NSString*) groupName;

-(void) addStudentOnName: (NSString*) fullName
              onBirthDay: (NSString*) birthDay
                 onPhoto: (NSData*) photo
                forGroup: (NSString*) groupName;

-(OSGroup*) getGroupOnName: (NSString*) groupName;

-(NSArray*) getStudentsForGroup: (NSString*) groupName;

-(void) deleteStudent:(OSStudent*) student;

- (NSArray*) allObjects;

- (void) printAllObjects;

- (void) deleteAllObjects;

@end
