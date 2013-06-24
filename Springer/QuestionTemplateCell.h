//
//  QuestionTemplateCell.h
//  Springer
//
//  Created by PUN-MAC-012 on 26/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTemplateCell : UITableViewCell


@property (nonatomic, retain) IBOutlet UILabel *lbl_AnsNo;
@property (nonatomic, retain) IBOutlet UIView *redLine_View1;
@property (nonatomic, retain) IBOutlet UIView *redLine_View2;
@property (nonatomic, retain) IBOutlet UIWebView *web_option;
@property (nonatomic, retain) IBOutlet UIView *selection_View;
@property (nonatomic, retain) IBOutlet UIImageView *img_answer;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellWidth:(float)cellwidth rowHeight:(float)rowHeight isBrowse:(BOOL)browse;

@end
