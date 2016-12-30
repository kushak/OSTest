//
//  OSAddStudentVC.h
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSStudent+CoreDataClass.h"

@interface OSAddStudentVC : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSString* groupName;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UITextField *fullName;
@property (weak, nonatomic) IBOutlet UITextField *birthDay;
@property (strong, nonatomic) OSStudent* student;

@end
