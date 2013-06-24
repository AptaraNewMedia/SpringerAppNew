//
//  QuestionSetViewController.m
//  Springer
//
//  Created by PUN-MAC-012 on 03/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "QuestionSetViewController.h"
#import "QuestionsWithImagesController.h"
#import "QuizResultViewController.h"
#import "Questions.h"
#import "QuizScore.h"
#import <QuartzCore/QuartzCore.h>
#import "QuizReviewViewController.h"
#import "CustomLeftBarItem.h"
#import "CustomRightBarItem.h"
#import "CustomButton.h"
#import "CustomTitle.h"

#import "Notes.h"
#import "Favourites.h"

@interface QuestionSetViewController ()
{
    IBOutlet UIView *viewProgressPatch;
    
    IBOutlet UIImageView *imgProgressBG;
    IBOutlet UIImageView *imgFlagNoteBG;
    
    IBOutlet UILabel *lblQuestionNo;
    IBOutlet UILabel *lblTime;
    
    IBOutlet UIButton *btnNext;
    IBOutlet UIButton *btnPrev;
    
    IBOutlet UIButton *btnReview;
    IBOutlet UIView *btnReviewPatch;
    
    IBOutlet UIView *viewQuestion;
    IBOutlet UIButton *btn_Flag;
    IBOutlet UIButton *btn_Note;
    IBOutlet UIImageView *imgTapBar;
    IBOutlet UIImageView *imgClock;
    
    IBOutlet UIProgressView *progressView;
    
    NSInteger currentQuestion;
    NSInteger currentQuiz;
    NSInteger totalQestions;
    NSInteger score;
    
    NSTimer *timer;
    Boolean boolTimer;
    Boolean boolRandom;

    NSMutableArray *questiondData;
    
    QuizScore *objQuizScore;
    Questions *objQues;
    UIAlertView *alertViews;
    NSInteger currentOrientaion;

    CustomLeftBarItem *customLeftBar;
    CustomRightBarItem *customRightBar;
    CustomButton *ReviewcustomButton;
    CustomTitle *Title;

    
    QuestionsWithImagesController *questionsWithImagesController;
    
    Notes *objNotes;
    Favourites *objFavourites;
    
    int secondsLeft;
    int timerCount;
    int perQuestion;
    int prevOrientation;
}

-(void)fnSetFontColor;
-(void)fnSetNavigationItems;
-(void)fnSetVariables;
-(void)fnRotatePortrait;
-(void)fnRotateLandscape;
-(void)fnSetCustomButton;
-(void)fnCheckNoteFavourites;


-(IBAction)OnPrevQuestionTapped:(id)sender;
-(IBAction)OnNextQuestionTapped:(id)sender;
-(IBAction)OnPreviewTapped:(id)sender;
-(IBAction)OnNoteTapped:(id)sender;
-(IBAction)OnFavoritesTapped:(id)sender;

@end


@implementation QuestionSetViewController


#pragma mark - Defaults
//-----------------------------------------
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];    
    float currentVersion = 6.0;

    currentQuestion = FROM_REVIEW_TO_QUIZ;
    [self fnCreateQuestions];
    [self fnDisableNextPrev];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= currentVersion)
    {        
        [self supportedInterfaceOrientations];
    }
    else{
        [self shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
    }
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title= @"Quiz ";
    [self fnSetFontColor];
    [self fnSetVariables];
    [self fnSetNavigationItems];
    [self fnSetCustomButton];
    [self fnAddSwipeGesture];
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-----------------------------------------

#pragma mark - Normal Functions
//-----------------------------------------
-(void)fnSetData:(NSArray *)data AndTimer:(BOOL)bTimer AndCurrentQuestion:(int)currQuestion AndQuizScoreId:(int)quizScoreId
{
    questiondData = [data copy];
    totalQestions = [questiondData count];
    currentQuestion = currQuestion;
    boolTimer = bTimer;
    
    objQuizScore = [db fnGetQuizScoreObjectByQuizScoreId:quizScoreId];

    [self fnCreateQuestions];
    [self fnDisableNextPrev];
    if (boolTimer) {
        progressView.hidden = NO;
        lblTime.hidden = NO;
        imgClock.hidden=NO;
        secondsLeft = perQuestion * totalQestions;
        [self fnSetTimer];
    }
}
-(void)fnSetNoteIcon:(BOOL)flag
{
    btn_Note.selected = flag;
}
-(void)fnCheckNoteFavourites
{
    
    Questions *objQues1 = (Questions *)[questiondData objectAtIndex:currentQuestion];
    
    // Check Note
    objNotes = [db fnGetNote:objQues1.intQuestionId AndChapterID:objQues1.intChapterId AndQuizScoreId:objQuizScore.intScoreId];
    
    if (objNotes != nil) {
        objNotes.intmode = 2;
        btn_Note.selected = YES;
        
    }
    else {
        objNotes = [[Notes alloc] init];
        objNotes.intmode = 1;
        objNotes.strcreated_date = CURRENT_DATE;
        objNotes.intscore_id = objQuizScore.intScoreId;
        
        btn_Note.selected = NO;
    }

    objNotes.strmodified_date = CURRENT_DATE;
    objNotes.intquestion_id = objQues1.intQuestionId;
    objNotes.intchapter_id = objQues1.intChapterId;

    // Check Favourites
    
    objFavourites = [db fnCheckFavourites: objQues1.intQuestionId AndChapterID:objQues1.intChapterId AndQuizScoreId:objQuizScore.intScoreId];
    
    if (objFavourites != nil) {
        objFavourites.intmode = 2;
        btn_Flag.selected = YES;
    }
    else {
        btn_Flag.selected = NO;
        objFavourites = [[Favourites alloc] init];
        objFavourites.intmode = 1;
        objFavourites.strcreated_date = CURRENT_DATE;
    }
    
    objFavourites.intscore_id = objQuizScore.intScoreId;
    objFavourites.strmodified_date = CURRENT_DATE;
    objFavourites.intquestion_id = objQues1.intQuestionId;
    objFavourites.intchapter_id = objQues1.intChapterId;

    
}
-(void)fnSetFontColor
{
    lblQuestionNo.textColor = COLOR_WHITE;
    lblQuestionNo.font=FONT_Trebuchet_MS_24;
    lblQuestionNo.shadowColor = COLOR_BG_BLACK_30;
    lblQuestionNo.shadowOffset = CGSizeMake(0, 3.0);

    lblTime.textColor =COLOR_WHITE;
    lblTime.font = FONT_Trebuchet_MS_17;
    lblTime.shadowColor = COLOR_BG_BLACK_30;
    lblTime.shadowOffset = CGSizeMake(0, 3.0);
    
    
//    lblQuestionNo.font = FONT_Helvetica_17;
//    lblTime.font = FONT_Helvetica_17;
    
    viewProgressPatch.backgroundColor=COLOR_BG_BLUE;
    
    btnReview.backgroundColor = COLOR_CLEAR;
    CALayer *layer = [btnReviewPatch layer];
    [layer setCornerRadius:6.0];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.8 green:0.808 blue:0.82 alpha:1];
    viewQuestion.backgroundColor = [UIColor colorWithRed:0.8 green:0.808 blue:0.82 alpha:1];    

}
-(void)fnSetNavigationItems
{
    customLeftBar = [[CustomLeftBarItem alloc] initWithFrame:CGRectMake(5, 6, 73, 34)];
    customLeftBar.btnBack.frame=CGRectMake(0, 0,73,34);   
    [customLeftBar.btnBack setTitle:@"  Exit Quiz" forState:UIControlStateNormal];
    [customLeftBar.btnBack setTitle:@"  Exit Quiz" forState:UIControlStateHighlighted];
    UIBarButtonItem *btnBar1 = [[UIBarButtonItem alloc] initWithCustomView:customLeftBar];
    self.navigationItem.leftBarButtonItem = btnBar1;
    [customLeftBar.btnBack addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    customLeftBar.btnBack.hidden = NO;
    
    
    customRightBar = [[CustomRightBarItem alloc] initWithFrame:CGRectMake(0, 0, 34, 44)];
    customRightBar.btnhelp.frame=CGRectMake(0, 6, 34, 34);
    UIBarButtonItem *btnBar2 = [[UIBarButtonItem alloc] initWithCustomView:customRightBar];
    self.navigationItem.rightBarButtonItem = btnBar2;
    customRightBar.btnInfo.hidden = YES;
    
    Title=[[CustomTitle alloc]initWithFrame:CGRectMake(100, 0, 400, 44)];
    Title.LblTitle.text=@"Quiz";
    self.navigationItem.titleView=Title;
}
-(void)fnSetCustomButton
{
    
    ReviewcustomButton = [[CustomButton alloc]initWithFrame:CGRectMake(324,915,176,39)];
    [ReviewcustomButton.btn setTitle:@"Review" forState:UIControlStateNormal];
    [ReviewcustomButton.btn addTarget:self action:@selector(OnPreviewTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:ReviewcustomButton];
    
    
    
}
-(void)fnSetVariables
{
    int minutes = (secondsLeft % 3600) / 60;
    int seconds = (secondsLeft % 3600) % 60;
    int hours = (secondsLeft / 3600);
    lblTime.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    
    progressView.hidden = YES;
    lblTime.hidden = YES;
    imgClock.hidden=YES;
    
    progressView.progress = 0;
    
    perQuestion = 60;
}
-(void)fnDisableNextPrev
{
    if (currentQuestion == 0) {
        btnPrev.enabled = NO;
    }
    if (currentQuestion == totalQestions - 1 ) {
        btnNext.enabled = NO;
    }
}

-(void)fnCreateQuestions
{
    if (questionsWithImagesController) {
        [questionsWithImagesController.view removeFromSuperview];
    }
    
    Questions *objQues1 = (Questions *)[questiondData objectAtIndex:currentQuestion];
    
    questionsWithImagesController = [[QuestionsWithImagesController alloc] init];

    [questionsWithImagesController fnSetData:objQues1 AndParentObject:self];
    
    questionsWithImagesController.strSelectedAnswer = [objQuizScore.arrQuizVisitedAnswers objectAtIndex:currentQuestion];
    
    [viewQuestion addSubview:questionsWithImagesController.view];
    
    [self fnLabelCurrentQuestion];
    
    [self fnCheckNoteFavourites];
    
    [self fnCallOrientationOfTemplates];    
    
    float val = ((float)(currentQuestion+1)/totalQestions);
    progressView.progress = val;
    
}
-(void)fnLabelCurrentQuestion
{
    lblQuestionNo.text = [NSString stringWithFormat:@"%d/%d", currentQuestion+1, totalQestions];
}
-(void)fnUpdateQuizScore
{

    int correct = [questionsWithImagesController fnCheckAnswer];
    [objQuizScore.arrQuizVisitedAnswers replaceObjectAtIndex:currentQuestion withObject:questionsWithImagesController.strSelectedAnswer];
    
    [objQuizScore.arrCorrectIncorrectAnswers replaceObjectAtIndex:currentQuestion withObject:[NSNumber numberWithInt:correct]];
    objQuizScore.intCurrentQuestion = currentQuestion;
    
    //[db fnUpdateQuizScoreDataOnSubmit:objQuizScore];
    
}
-(void)fnAddSwipeGesture
{
    // swipe------------------------------
    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(OnNextQuestionTapped:)];
    
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [viewQuestion addGestureRecognizer:oneFingerSwipeLeft];
    
    
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(OnPrevQuestionTapped:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [viewQuestion addGestureRecognizer:oneFingerSwipeRight];
}
-(void)fnSetTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                             target: self
                                           selector: @selector(timerFired:)
                                           userInfo: nil
                                            repeats: YES];
}
-(void)fnCallOrientationOfTemplates
{
    [questionsWithImagesController shouldAutorotateToInterfaceOrientation:currentOrientaion];    
}
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//    self.view.userInteractionEnabled = TRUE;
//}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self performSelector:@selector(setHalfTime) withObject:self afterDelay:0.02];
}
-(void)setHalfTime {
   self.view.userInteractionEnabled = TRUE;
}
-(void)timerFired: (NSTimer *) theTimer
{
	if (secondsLeft < 1) {
		secondsLeft = 0;
        [timer invalidate];
		timer = nil;
		UIAlertView* dialog = [[UIAlertView alloc] init];
        dialog.delegate = self;
		[dialog setTitle:@"Alert"];
		[dialog setMessage:@"\nYou ran out of time!"];
		[dialog addButtonWithTitle:BTN_OK];
		[dialog show];
    }
    else {
        secondsLeft--;
        timerCount++;
        int minutes = (secondsLeft % 3600) / 60;
        int seconds = (secondsLeft % 3600) % 60;
        int hours = (secondsLeft / 3600);
        lblTime.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
    
    
}
-(void)removeTimer
{
    [timer invalidate];
    timer = nil;
}
//-----------------------------------------


#pragma mark - Button Actions
//-----------------------------------------
-(IBAction)onBack:(id)sender
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)OnPrevQuestionTapped:(id)sender
{
    //    [self fnUpdateQuizScore];
//   
    if (currentQuestion == 0) {
        return;
    }
    currentQuestion--;
    FROM_REVIEW_TO_QUIZ = currentQuestion;
    [self fnCreateQuestions];
    btnNext.enabled = YES;
    if (currentQuestion == 0) {
        btnPrev.enabled = NO;
    }
     self.view.userInteractionEnabled = FALSE;
    CATransition *transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.duration = 0.40;
    transition.type=kCATransitionPush;
    transition.subtype=kCATransitionFromLeft;
    transition.delegate = self;
    [viewQuestion.layer addAnimation:transition forKey:nil];
    
    
}
-(IBAction)OnNextQuestionTapped:(id)sender
{
    //    [self fnUpdateQuizScore];
    if (currentQuestion == totalQestions-1) {
        //        alertViews = [[UIAlertView alloc] init];
        //        alertViews.title = TITLE_MSG;
        //        alertViews.delegate = self;
        //        alertViews.message = ALERT_SUBMIT_RESULT;
        //        [alertViews addButtonWithTitle:BTN_REVIEW];
        //        [alertViews addButtonWithTitle:BTN_SUBMIT];
        //        [alertViews show];
        return;
    }
    currentQuestion++;
    FROM_REVIEW_TO_QUIZ = currentQuestion;
    [self fnCreateQuestions];
    btnPrev.enabled = YES;    
    if (currentQuestion == totalQestions-1) {
        btnNext.enabled = NO;
    }
    
    
    self.view.userInteractionEnabled = FALSE;

    CATransition *transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.duration = 0.40;
    transition.type=kCATransitionPush;
    transition.subtype=kCATransitionFromRight;
    transition.delegate = self;
    [viewQuestion.layer addAnimation:transition forKey:nil];
    
}
-(IBAction)OnPreviewTapped:(id)sender
{
    QuizReviewViewController *review = [[QuizReviewViewController alloc] initWithNibName:@"QuizReviewViewController_Ipad" bundle:nil];
    [review fnSetData:questiondData AndScore:objQuizScore FromQuizResult:0 AndParent:self];
    [self.navigationController pushViewController:review animated:YES];
}
-(IBAction)OnNoteTapped:(id)sender
{
    [md Fn_AddNote: objNotes];
}
-(IBAction)OnFavoritesTapped:(id)sender
{
    if (objFavourites.intmode == 1) {
        [db fnSetFavourite:objFavourites];
        objFavourites.intmode = 2;
        btn_Flag.selected = YES;
        
    }
    else {
        [db fnDeleteFavourite:objFavourites];
        objFavourites.intmode = 1;
        btn_Flag.selected = NO;
    }

}
//-----------------------------------------


#pragma mark - AlertView
//-----------------------------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	
    if([title isEqualToString:BTN_SUBMIT])
    {
        
    }
    else if([title isEqualToString:BTN_REVIEW])
    {
        QuizReviewViewController *review = [[QuizReviewViewController alloc] initWithNibName:@"QuizReviewViewController_Ipad" bundle:nil];
        [review fnSetData:questiondData AndScore:objQuizScore FromQuizResult:0 AndParent:self];
        [self.navigationController pushViewController:review animated:YES];
    }
    else if([title isEqualToString:BTN_OK])
    {
        QuizResultViewController *result = [[QuizResultViewController alloc] init];
        objQuizScore.intMissedQuestion=0;
        objQuizScore.intcorrectAns=0;
        objQuizScore.intIncorrectAns=0;
        objQuizScore.intTotalScore=0;
        
        
        [result fnSetData:questiondData AndScore:objQuizScore];
        [self.navigationController pushViewController:result animated:YES];
        
        
        for (int i=0; i < [objQuizScore.arrCorrectIncorrectAnswers count]; i++) {
            
            int val = [[objQuizScore.arrCorrectIncorrectAnswers objectAtIndex:i] intValue];
            
            if (val == 0) {
                objQuizScore.intMissedQuestion++;
            }
            else if (val == 1) {
                objQuizScore.intcorrectAns++;
            }
            else if (val == 2) {
                objQuizScore.intIncorrectAns++;
            }
        }
        
        objQuizScore.intTotalScore = ( objQuizScore.intcorrectAns * 100 ) / totalQestions ;
        result.lblTotalQuestion.text = [NSString stringWithFormat:@"%d", objQuizScore.arrCorrectIncorrectAnswers.count];
        
        result.lblTitle.text=[NSString stringWithFormat:@"%@", objQuizScore.strQuizName];
        
        result.lblAnsSubmited.text = [NSString stringWithFormat:@"%d", objQuizScore.intcorrectAns+objQuizScore.intIncorrectAns];
        
        result.lblCorrect.text = [NSString stringWithFormat:@"%d", objQuizScore.intcorrectAns];
        
        result.lblIncorrect.text = [NSString stringWithFormat:@"%d", objQuizScore.intIncorrectAns];
        
        result.lblPerformance.text = [NSString stringWithFormat:@"%d%%", objQuizScore.intTotalScore];
        
        [db fnUpdateQuizScoreData:objQuizScore];
    }
}
//-----------------------------------------


#pragma mark - Rotations
//-----------------------------------------
-(BOOL)shouldAutorotate{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[UIApplication sharedApplication].statusBarOrientation;
    currentOrientaion = interfaceOrientation;
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations
{
    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        return NO;
    }
    
    NSUInteger mask= UIInterfaceOrientationMaskPortrait;
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    currentOrientaion = interfaceOrientation;
    
    if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft){
        [self fnRotateLandscape];
        
        mask  |= UIInterfaceOrientationMaskLandscapeLeft;
        
    }
    else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        [self fnRotateLandscape];
        mask |= UIInterfaceOrientationMaskLandscapeRight;
        
	}
	else if(interfaceOrientation==UIInterfaceOrientationPortrait){
        [self fnRotatePortrait];
        mask  |=UIInterfaceOrientationMaskPortraitUpsideDown;
        
	}
	else {
        [self fnRotatePortrait];
        mask  |=UIInterfaceOrientationMaskPortrait;
        
	}
    return UIInterfaceOrientationMaskAll;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    currentOrientaion = interfaceOrientation;
    
    if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft){
        [self fnRotateLandscape];
        return YES;
    }
    else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
		[self fnRotateLandscape];
        return YES;
	}
	else if(interfaceOrientation==UIInterfaceOrientationPortrait){
		[self fnRotatePortrait];
        return YES;
	}
	else {
        [self fnRotatePortrait];
        return YES;
	}
    
	return YES;
}
-(void)fnRotatePortrait
{
    //self.view.frame = CGRectMake(0, 0, 768, 1024);
    
    NSString *str=questionsWithImagesController.imageShowFalg;
    NSLog(@"%@",str);
    [viewProgressPatch setFrame:CGRectMake(0,0,768, 77)];
    [imgProgressBG setFrame:CGRectMake(0,0,768, 77)];
    [imgProgressBG setImage:[UIImage imageNamed:@"img_View_Progressbar_bg_P"]];
    [imgFlagNoteBG setFrame:CGRectMake(0,60,768,38)];
    [imgFlagNoteBG setImage:[UIImage imageNamed:@"img_View_Flag_Note_bg_P"]];
    [lblQuestionNo setFrame:CGRectMake(77,18,100,26)];
    [lblTime setFrame:CGRectMake(689,21,82,20)];
    [imgClock setFrame:CGRectMake(657,  16, 27, 32)];
    [progressView setFrame:CGRectMake(234, 26, 300, 32)];

    [btnNext setFrame:CGRectMake(738,474.5,30,55)];
    [btnPrev setFrame:CGRectMake(0,474.5,30,55)];
    [ReviewcustomButton setFrame:CGRectMake(298,918,176,39)];
    [viewQuestion setFrame:CGRectMake(0,90,768,900)];
    [btn_Flag setFrame:CGRectMake(680,65,17,22)];
    [btn_Note setFrame:CGRectMake(715,66,17,22)];
    [imgTapBar setFrame:CGRectMake(0,915,768,48)];
    [imgTapBar setImage: [UIImage imageNamed:@"Img_Tabbar_P"]];
    [Title setFrame:CGRectMake(184, 0, 400, 44)];
    if (currentOrientaion != prevOrientation) {
        [self fnCreateQuestions];
    }
    prevOrientation = currentOrientaion;
    questionsWithImagesController.imageShowFalg=str;

    //[questionsWithImagesController fnRotatePortrait];

}
-(void)fnRotateLandscape
{
    //self.view.frame = CGRectMake(0, 0, 1024, 768);
    
    NSString *str=questionsWithImagesController.imageShowFalg;
    NSLog(@"%@",str);
    [viewProgressPatch setFrame:CGRectMake(0,0,1024, 77)];
    [imgProgressBG setFrame:CGRectMake(0,0,1024,77)];
    [imgProgressBG setImage:[UIImage imageNamed:@"img_View_Progressbar_bg.png"]];
    [imgFlagNoteBG setFrame:CGRectMake(0,60,1024,39)];
    [imgFlagNoteBG setImage:[UIImage imageNamed:@"img_View_Flag_Note_bg"]];
    [lblQuestionNo setFrame:CGRectMake(77,18,100,26)];
    [btn_Flag setFrame:CGRectMake(928,65,17,22)];
    [btn_Note setFrame:CGRectMake(964,66,17,22)];
    [lblTime setFrame:CGRectMake(938,21,82,20)];
    [imgClock setFrame:CGRectMake(905, 16, 27, 32)];
    [progressView setFrame:CGRectMake(362, 26, 300, 32)];

    [btnNext setFrame:CGRectMake(994,346,30,55)];
    [btnPrev setFrame:CGRectMake(0,346,30,55)];
    [ReviewcustomButton setFrame:CGRectMake(424,661,176,39)];
    [viewQuestion setFrame:CGRectMake(0,90,1024,644)];
  
    [imgTapBar setFrame:CGRectMake(0,656,1024,48)];
    [imgTapBar setImage: [UIImage imageNamed:@"Img_Tabbar"]];
   [Title setFrame:CGRectMake(312, 0, 400, 44)];

    if (currentOrientaion != prevOrientation) {
        [self fnCreateQuestions];
    }
    prevOrientation = currentOrientaion;

    questionsWithImagesController.imageShowFalg=str;
    
    //[questionsWithImagesController fnRotateLandscape];

}
//-----------------------------------------

@end
