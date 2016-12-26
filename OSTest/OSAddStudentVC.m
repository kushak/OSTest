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

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UITextField *fullName;
@property (weak, nonatomic) IBOutlet UITextField *birthDay;
@property (weak, nonatomic) IBOutlet UILabel *warningLable;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation OSAddStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 550)];
    
    UITapGestureRecognizer* pan=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabBegin:)];
    [self.scrollView addGestureRecognizer:pan];
    pan.cancelsTouchesInView = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.photo.image = pickedImage;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification {
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardBeginFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.view.frame;
    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
    CGRect keyboardFrameBegin = [self.view convertRect:keyboardBeginFrame toView:nil];
    
    newFrame.origin.y -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
    self.scrollView.frame = newFrame;
    
    [UIView commitAnimations];
}

-(void)tabBegin:(UITapGestureRecognizer*)pan{
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
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
        [[OSDataManager sharedManager]
         addStudentOnName:self.fullName.text
         onBirthDay:self.birthDay.text
         onPhoto:UIImageJPEGRepresentation(self.photo.image, 1.0)
         forGroup:self.groupName];
        
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.warningLable.alpha = 1;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
