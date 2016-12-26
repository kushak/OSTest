//
//  OSDataManager.m
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//

#import "OSDataManager.h"
#import "OSStudent+CoreDataProperties.h"
#import "OSGroup+CoreDataProperties.h"

@implementation OSDataManager



+(OSDataManager*) sharedManager {
    
    static OSDataManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OSDataManager alloc] init];
    });
    
    return manager;
}
-(void) addGroup: (NSString*) groupName {
    OSGroup* group = [NSEntityDescription insertNewObjectForEntityForName:@"OSGroup" inManagedObjectContext:self.persistentContainer.viewContext];
    group.name = groupName;
    [self saveContext];
}

-(void) addStudentOnName: (NSString*) fullName
              onBirthDay: (NSString*) birthDay
                 onPhoto: (NSData*) photo
                forGroup: (NSString*) groupName {
    OSStudent* student = [NSEntityDescription insertNewObjectForEntityForName:@"OSStudent" inManagedObjectContext:self.persistentContainer.viewContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"OSGroup" inManagedObjectContext:self.persistentContainer.viewContext];
    [request setEntity:description];
    
    NSArray* groups = [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
    for (OSGroup* group in groups) {
        if([group.name isEqualToString:groupName]) {
            student.group = group;
        }
    }
    
    student.fullName = fullName;
    student.birthDay = birthDay;
    student.photo = photo;
    
    [self saveContext];
}

-(OSGroup*) getGroupOnName: (NSString*) groupName {
    OSGroup* resultGroup = nil;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"OSGroup" inManagedObjectContext:self.persistentContainer.viewContext];
    [request setEntity:description];
    
    NSArray* groups = [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
    for (OSGroup* group in groups) {
        if([group.name isEqualToString:groupName]) {
            resultGroup = group;
        }
    }
    return resultGroup;
}

-(NSArray*) getStudentsForGroup: (NSString*) groupName {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"OSStudent" inManagedObjectContext:self.persistentContainer.viewContext];
    [request setEntity:description];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"group.name == %@", groupName];
    [request setPredicate:predicate];
    
    NSArray* students = [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
    
    return students;
}

-(void) deleteStudent:(OSStudent*) student {
    [self.persistentContainer.viewContext deleteObject:student];
    [self.persistentContainer.viewContext save:nil];
}

- (NSArray*) allObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"OSObject"
                inManagedObjectContext:self.persistentContainer.viewContext];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

- (void) printAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    for (id object in allObjects) {
        
        if ([object isKindOfClass:[OSGroup class]]) {
            
            OSGroup* group = (OSGroup*) object;
            NSLog(@"Groupe: %@", group.name);
            for (id object2 in group.students) {
                OSStudent* student = (OSStudent*) object2;
                NSLog(@"Student: %@", student.fullName);
            }
        }
    }
}

- (void) deleteAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    for (id object in allObjects) {
        [self.persistentContainer.viewContext deleteObject:object];
    }
    [self.persistentContainer.viewContext save:nil];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"OSTest"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
@end
