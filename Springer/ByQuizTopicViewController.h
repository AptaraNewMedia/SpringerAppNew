//
//  QuizResultViewController.h
//  Springer1.1
//
//  Created by PUN-MAC-012 on 08/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ByQuizTopicViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *Tbl_view;


@property (strong, nonatomic) IBOutlet UIView *View_Tbl;
@property (strong, nonatomic) IBOutlet UIImageView *Img_bg;
@property (nonatomic) int int_modebyTopicQuiz;

//-(IBAction)onReview:(id)sender;


@end
