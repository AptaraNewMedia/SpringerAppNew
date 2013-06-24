//
//  QuestionTemplateCell.m
//  Springer
//
//  Created by PUN-MAC-012 on 26/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "QuestionTemplateCell.h"

@implementation QuestionTemplateCell
@synthesize lbl_AnsNo;
@synthesize redLine_View1;
@synthesize redLine_View2;
@synthesize web_option;
@synthesize selection_View;
@synthesize img_answer;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellWidth:(float)cellwidth rowHeight:(float)rowHeight isBrowse:(BOOL)browse
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        selection_View=[[UIView alloc]initWithFrame:CGRectMake(0, 0, cellwidth, rowHeight)];
        selection_View.backgroundColor=COLOR_CLEAR;
        [self.contentView addSubview:selection_View];
        
        lbl_AnsNo=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 54, rowHeight)];
        lbl_AnsNo.backgroundColor = COLOR_CLEAR;
        lbl_AnsNo.font = FONT_Trebuchet_MS_bold_17;
        lbl_AnsNo.textColor = COLOR_BG_BLUE;
        lbl_AnsNo.textAlignment=UITextAlignmentCenter;
        [self.contentView addSubview:lbl_AnsNo];        
        
        web_option=[[UIWebView alloc]initWithFrame:CGRectMake(66, 1, cellwidth - 86, rowHeight)];
        web_option.userInteractionEnabled =NO;
        web_option.backgroundColor = COLOR_CLEAR;
        web_option.opaque = NO;
        [self.contentView addSubview:web_option];        
        
        redLine_View1=[[UIView alloc]initWithFrame:CGRectMake(53, 0, 1, rowHeight)];
        redLine_View1.backgroundColor=COLOR_RED_Line;
        [self.contentView addSubview:redLine_View1];
        
        redLine_View2=[[UIView alloc]initWithFrame:CGRectMake(55, 0, 1, rowHeight)];
        redLine_View2.backgroundColor=COLOR_RED_Line;
        [self.contentView addSubview:redLine_View2];
        
        if (browse) {
            [web_option setFrame:CGRectMake(66, 0, cellwidth - 126, rowHeight)];
            img_answer = [[UIImageView alloc]initWithFrame:CGRectMake(cellwidth-70, 5, 31, 24)];
            [self.contentView addSubview:img_answer];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
