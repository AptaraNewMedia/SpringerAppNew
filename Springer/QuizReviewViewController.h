//
//  QuizReviewViewController.h
//  Springer1.1
//
//  Created by PUN-MAC-014 on 25/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuizScore;

@interface QuizReviewViewController : UIViewController
{
    IBOutlet UITableView *view_ReviewTbl;
    IBOutlet UIImageView *ing_bg;
    IBOutlet UIView *BlackView;
    
}
@property(nonatomic,retain) UITableView *view_ReviewTbl;
@property(nonatomic,retain)IBOutlet  UIView *BlackView;
@property(nonatomic,retain)IBOutlet UIImageView *ing_bg;
-(void) fnSetData:(NSArray *)data AndScore:(QuizScore *)score FromQuizResult:(int)flag AndParent:(id)parent;
-(void)show_Data:(UIButton *)btn;
@end
