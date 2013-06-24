//
//  ReviewTableCell.h
//  Springer1.1
//
//  Created by PUN-MAC-014 on 25/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewTableCell : UITableViewCell
{
IBOutlet UIImageView *Img_TableCellBG;
IBOutlet UILabel *Lbl_Qno;
IBOutlet UILabel *Lbl_Questiontlbl;
IBOutlet UILabel *Lbl_Qstatus;
IBOutlet UILabel *Lbl_Quesion;
IBOutlet UIButton *Btn_Show;
IBOutlet UIButton *Btn_Img1;
IBOutlet UIButton *Btn_Img2;
IBOutlet UIImageView *Img_Answer;
    IBOutlet UIView *selection_view;
    IBOutlet UIWebView *webvieQuestion;
    
}
@property (nonatomic, retain) IBOutlet UIImageView *Img_TableCellBG;
@property (nonatomic, retain) IBOutlet UILabel *Lbl_Qno;
@property (nonatomic, retain) IBOutlet UILabel *Lbl_Qstatus;
@property (nonatomic, retain) IBOutlet UILabel *Lbl_Quesion;
@property (nonatomic, retain) IBOutlet UIButton *Btn_Show;
@property (nonatomic, retain) IBOutlet UIButton *Btn_Img1;
@property (nonatomic, retain) IBOutlet UIButton *Btn_Img2;
@property (nonatomic, retain) IBOutlet UILabel *Lbl_Questiontlbl;
@property (nonatomic, retain) IBOutlet UIImageView *Img_Answer;
@property (nonatomic, retain) IBOutlet UIView *selection_view;
@property (nonatomic, retain) IBOutlet UIWebView *webvieQuestion;
@end
