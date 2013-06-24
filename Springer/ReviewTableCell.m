//
//  ReviewTableCell.m
//  Springer1.1
//
//  Created by PUN-MAC-014 on 25/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "ReviewTableCell.h"

@implementation ReviewTableCell
@synthesize imageView,Img_TableCellBG,Btn_Img1,Btn_Img2,Btn_Show,Lbl_Qno,Lbl_Qstatus,Lbl_Quesion,Lbl_Questiontlbl, Img_Answer,selection_view,webvieQuestion;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
