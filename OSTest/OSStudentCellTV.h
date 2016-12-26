//
//  OSStudentCellTV.h
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSStudent+CoreDataClass.h"

@interface OSStudentCellTV : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *birthDay;

-(void) fillCellWithStudent: (OSStudent*) student;

@end
