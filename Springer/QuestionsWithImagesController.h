//
//  QuestionsWithImagesController.h
//  Springer1.1
//
//  Created by PUN-MAC-012 on 06/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Questions;

@interface QuestionsWithImagesController : UIViewController <UIScrollViewDelegate,UIWebViewDelegate>

@property (nonatomic, retain) NSString *strSelectedAnswer;
@property (nonatomic, retain) NSString *imageShowFalg;


-(void)fnSetData:(Questions *)objQuestionData AndParentObject:(id)parentobject;
-(int) fnCheckAnswer;
-(void)fnRotatePortrait;
-(void)fnRotateLandscape;
//-(void)imageorientation:(NSString *)str;
@end
