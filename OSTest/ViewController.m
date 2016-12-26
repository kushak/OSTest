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

-(void) presntVCForGroup: (NSString*) groupName {
    OSStudentsTVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"students"];
    vc.group = groupName;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Actions
- (IBAction)ipsumButtonPressed:(id)sender {
    if(![[OSDataManager sharedManager] getGroupOnName:@"ipsum"]) {
        [[OSDataManager sharedManager] addGroup:@"ipsum"];
        if([[[OSDataManager sharedManager] getStudentsForGroup:@"ipsum"] count] == 0 ){
            for (NSInteger i = 1; i <= 3 ; i++) {
                [[OSDataManager sharedManager]
                 addStudentOnName: [NSString stringWithFormat:@"Test Student %ld", (long)i]
                 onBirthDay:[NSString stringWithFormat:@"%u.%u.%u", arc4random_uniform(30)+1,
                             arc4random_uniform(12)+1, arc4random_uniform(15)+1980]
                 onPhoto:UIImageJPEGRepresentation([UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)i]], 1.0)
                 forGroup:@"ipsum"];
            }
        }
    }
    [self presntVCForGroup:@"ipsum"];
}
- (IBAction)loreamButtonPressed:(id)sender {
    if(![[OSDataManager sharedManager] getGroupOnName:@"loream"]) {
        [[OSDataManager sharedManager] addGroup:@"loream"];
        if([[[OSDataManager sharedManager] getStudentsForGroup:@"loream"] count] == 0 ){
            for (NSInteger i = 1; i <= 3 ; i++) {
                [[OSDataManager sharedManager]
                 addStudentOnName: [NSString stringWithFormat:@"Student Test %ld", (long)(i + 3)]
                 onBirthDay:[NSString stringWithFormat:@"%u.%u.%u", arc4random_uniform(30)+1,
                             arc4random_uniform(12)+1, arc4random_uniform(15)+1980]
                 onPhoto:UIImageJPEGRepresentation([UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)i]], 1.0)
                 forGroup:@"loream"];
            }
        }
    }
    [self presntVCForGroup:@"loream"];
}


-(NSManagedObjectContext*) context {
    if(!_context) {
        _context = [[[OSDataManager sharedManager] persistentContainer] viewContext];
    }
    
    return _context;
}



@end
