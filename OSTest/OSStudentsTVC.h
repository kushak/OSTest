//
//  OSStudentsTVC.h
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "OSStudent+CoreDataClass.h"

@interface OSStudentsTVC : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController<OSStudent *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext* context;
@property (strong, nonatomic) NSMutableArray* students;
@property (strong, nonatomic) NSString* group;

@end
