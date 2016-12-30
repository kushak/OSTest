//
//  OSAddStudentVC.m
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//

#import "OSAddStudentVC.h"
#import "OSDataManager.h"
#import "OSStudentsTVC.h"

@interface OSAddStudentVC ()


@property (weak, nonatomic) IBOutlet UILabel *warningLable;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation OSAddStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForKeyboardNotifications];
    
    UITapGestureRecognizer* pan=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabBegin:)];
    [self.scrollView addGestureRecognizer:pan];
    
    self.fullName.delegate = self;
    self.birthDay.delegate = self;
    
    if(self.student) {
        self.groupName = self.groupName;
        self.photo.image = [UIImage imageWithData:self.student.photo];
        self.fullName.text = [self.student fullName];
        self.birthDay.text = [self.student birthDay];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)tabBegin:(UITapGestureRecognizer*)pan{
    [self.view endEditing:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.photo.image = pickedImage;
}

#pragma mark - Actions

- (IBAction)photoButtonRessed:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)gallerieButtonPressed:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}
- (IBAction)saveButtonPressed:(id)sender {
    if(![self.fullName.text isEqualToString:@""]) {
        if(self.student) {
            
        } else {
            [[OSDataManager sharedManager]
             addStudentOnName:self.fullName.text
             onBirthDay:self.birthDay.text
             onPhoto:UIImageJPEGRepresentation(self.photo.image, 1.0)
             forGroup:self.groupName];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        self.warningLable.alpha = 1;
    }
}

#pragma mark - Keyboard

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(50.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(50.0, 0.0, 0.0, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
