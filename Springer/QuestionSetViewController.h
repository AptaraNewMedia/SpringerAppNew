//
//  QuestionSetViewController.h
//  Springer
//
//  Created by PUN-MAC-012 on 03/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionSetViewController : UIViewController
{
    
}

-(void) fnSetData:(NSArray *)data AndTimer:(BOOL)bTimer AndCurrentQuestion:(int)currQuestion AndQuizScoreId:(int)quizScoreId;
-(void)fnUpdateQuizScore;
-(void) removeTimer;

-(void)fnCreateQuestions;
-(void)fnLabelCurrentQuestion;
-(void)fnSetNoteIcon:(BOOL)flag;


@end
