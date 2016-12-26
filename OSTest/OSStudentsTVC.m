//
//  OSStudentsTVC.m
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//

#import "OSStudentsTVC.h"
#import "OSDataManager.h"
#import "OSStudent+CoreDataClass.h"
#import "OSStudentCellModel.h"
#import "OSStudentCellTV.h"
#import "OSAddStudentVC.h"

@interface OSStudentsTVC ()

@end

@implementation OSStudentsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Студенты"];
    [self reloadData];
}

-(void) viewWillAppear:(BOOL)animated {
    [self reloadData];
}

-(void) reloadData {
    self.students = [NSMutableArray arrayWithArray:[[OSDataManager sharedManager] getStudentsForGroup:self.group]];
    [self.tableView reloadData];
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.students.count + 1;
}

- (OSStudentCellTV *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OSStudentCellTV *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(indexPath.row == self.students.count) {
        cell.fullName.text = @"Добавить студента";
        cell.birthDay.text = nil;
        cell.photo.image = nil;
        return cell;
    }
    
    OSStudent *student = self.students[indexPath.row];
    
    [cell fillCellWithStudent:student];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == self.students.count) {
        OSAddStudentVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"add"];
        vc.groupName = self.group;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[OSDataManager sharedManager] deleteStudent:self.students[indexPath.row]];
        [self.students removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.students.count) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}


@end
