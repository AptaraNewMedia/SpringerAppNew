//
//  QuizResultViewController.h
//  Springer1.1
//
//  Created by PUN-MAC-012 on 08/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreQuizTopicViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblAnsSubmited;
@property (strong, nonatomic) IBOutlet UILabel *lblCorrect;
@property (strong, nonatomic) IBOutlet UILabel *lblIncorrect;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalQuestion;
@property (strong, nonatomic) IBOutlet UILabel *lblTitlePerformance;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleAnsSubmited;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleCorrect;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleIncorrect;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleTotalQuestion;
@property (strong, nonatomic) IBOutlet UILabel *lblPerformance;
@property (strong, nonatomic) IBOutlet UIView *View_Result;
@property (strong, nonatomic) IBOutlet UIImageView *Img_bg;

@end
