//
//  QuestionsWithImagesController.h
//  Springer1.1
//
//  Created by PUN-MAC-012 on 06/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Questions;

@interface BrouseQuestionsWithImagesController : UIViewController <UIScrollViewDelegate,UIWebViewDelegate>


@property (nonatomic, retain) NSString *strSelectedAnswer;
//@property (nonatomic, retain)BOOL ShowAnswer;

-(void)fnSetData:(Questions *)objQuestionData AndShowAnswer:(BOOL)answer AndParentObject:(id)parentobject AndRational:(BOOL)rational;
-(int) fnCheckAnswer;
-(void)fnRotatePortrait;
-(void)fnRotateLandscape;
-(void)Rationale;
-(void) fnDisableTable;

-(void)CheckAnswer;
-(int) fnShowAnswer;
-(int) fnCheckRational;

@end
