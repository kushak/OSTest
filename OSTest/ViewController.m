//
//  ViewController.m
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//

#import "ViewController.h"
#import "OSDataManager.h"
#import "OSStudentsTVC.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *ipsumButton;
@property (weak, nonatomic) IBOutlet UIButton *loreamButton;
@property (strong, nonatomic) NSManagedObjectContext* context;
@property (weak, nonatomic) IBOutlet UIButton *ipsumGruopButton;
@property (weak, nonatomic) IBOutlet UIButton *loreamGroupButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ipsumButton layoutIfNeeded];
    self.ipsumButton.layer.masksToBounds = YES;
    self.ipsumButton.layer.cornerRadius = self.ipsumButton.frame.size.height/3;
    
    [self.loreamGroupButton layoutIfNeeded];
    self.loreamGroupButton.layer.masksToBounds = YES;
    self.loreamGroupButton.layer.cornerRadius = self.loreamGroupButton.frame.size.height/3;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//-(void) presntVCForGroup: (NSString*) groupName {
//    OSStudentsTVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"students"];
//    vc.group = groupName;
//    [self.navigationController pushViewController:vc animated:YES];
//}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    OSStudentsTVC *vc = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"ipsum"]) {
        vc.groupName = @"ipsum";
    } else if ([segue.identifier isEqualToString:@"loream"]) {
        vc.groupName = @"loream";
    }
}

@end
