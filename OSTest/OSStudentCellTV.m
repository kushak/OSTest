//
//  OSStudentCellTV.m
//  OSTest
//
//  Created by user on 25.12.16.
//  Copyright © 2016 Oleg Shipulin. All rights reserved.
//

#import "OSStudentCellTV.h"

@implementation OSStudentCellTV

-(void) fillCellWithStudent: (OSStudent*) student {
    [self.photo layoutIfNeeded];
    self.photo.layer.masksToBounds = YES;
    self.photo.layer.cornerRadius = self.photo.frame.size.width/2;
    self.photo.image = [UIImage imageWithData: student.photo];
    self.fullName.text = student.fullName;
    self.birthDay.text = student.birthDay;
}

-(void) prepareForReuse {
    self.photo.image = nil;
    self.fullName.text = nil;
    self.birthDay.text = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
