//
//  QuizResultViewController.m
//  Springer1.1
//
//  Created by PUN-MAC-012 on 08/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "QuizScoreViewController.h"
#import "ByQuizTopicViewController.h"
#import "CustomLeftBarItem.h"
#import "CustomRightBarItem.h"
#import "CustomButton.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTitle.h"
#import "QuizScore.h"
#import "Questions.h"


@interface QuizScoreViewController ()
{
    CustomLeftBarItem *customLeftBar;
    CustomRightBarItem *customRightBar;
    CustomButton *ScoreQuizCustomButton;
    CustomButton *ScoreTopicCustomButton;
    CustomButton *ScoreDeleteCustomButton;
    CustomButton *ScoreCustomButton;
    CustomTitle *Title;
}
@end

@implementation QuizScoreViewController

@synthesize lblAnsSubmited;
@synthesize lblCorrect;
@synthesize lblIncorrect;
@synthesize lblTitleAnsSubmited;
@synthesize btnReview;
@synthesize View_Result;
@synthesize lblTitleCorrect;
@synthesize lblTitleIncorrect;
@synthesize lblTitlePerformance;
@synthesize lblTitleTotalQuestion;
@synthesize lblTotalQuestion;
@synthesize lblPerformance;
@synthesize Img_bg;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    float currentVersion = 6.0;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= currentVersion)
    {
        [self supportedInterfaceOrientations];
    }
    else{
        [self shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self fnSetFontColor];
    [self fnSetNavigationItems];
    [self fnSetCustomButton];
    [self fnSetCornerRadius];
    [self fnSetScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Normal Functions
//-----------------------------------------
-(void)fnSetFontColor
{
    self.view.backgroundColor = COLOR_BG_BLUE;
    View_Result.backgroundColor = COLOR_BG_BLACK;
    
    lblTitleTotalQuestion.textColor = COLOR_BG_BLUE;
    lblTitleAnsSubmited.textColor = COLOR_BG_BLUE;
    lblTitleCorrect.textColor = COLOR_BG_BLUE;
    lblTitleIncorrect.textColor = COLOR_BG_BLUE;
   lblTitlePerformance.textColor = COLOR_BG_BLUE;
    lblTotalQuestion.textColor = COLOR_TEXT_WHITE; 
    lblAnsSubmited.textColor = COLOR_TEXT_WHITE;
    lblCorrect.textColor = COLOR_TEXT_WHITE;
    lblIncorrect.textColor = COLOR_TEXT_WHITE;
    lblPerformance.textColor = COLOR_TEXT_WHITE;
   
    
    lblTotalQuestion.font = FONT_Trebuchet_MS_36;
    lblAnsSubmited.font = FONT_Trebuchet_MS_36;
    lblCorrect.font = FONT_Trebuchet_MS_36;
    lblIncorrect.font = FONT_Trebuchet_MS_36;
    lblPerformance.font = FONT_Trebuchet_MS_36;
    
    
    lblTitleTotalQuestion.font = FONT_Trebuchet_MS_18;
    lblTitleAnsSubmited.font = FONT_Trebuchet_MS_18;
    lblTitleCorrect.font = FONT_Trebuchet_MS_18;
    lblTitleIncorrect.font = FONT_Trebuchet_MS_18;
    lblTitlePerformance.font = FONT_Trebuchet_MS_18;
   
    

    
//    self.navigationController.navigationBar.backgroundColor = COLOR_BG_BLUE;
    
}
-(void)fnSetNavigationItems
{
    
    customLeftBar = [[CustomLeftBarItem alloc] initWithFrame:CGRectMake(5, 6, 73, 34)];
    customLeftBar.btnBack.frame=CGRectMake(0, 0,73,34);
    [customLeftBar.btnBack setTitle:@"  Home" forState:UIControlStateNormal];
    [customLeftBar.btnBack setTitle:@"  Home" forState:UIControlStateHighlighted];
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
    Title.LblTitle.text=@"Scores";
    self.navigationItem.titleView=Title;
    
}
-(void)fnSetCornerRadius
{
    CALayer *layer = [View_Result layer];
    [layer setCornerRadius:10.0];
    
   
    
}
-(void)fnSetCustomButton
{
    
    UIImage *img=[UIImage imageNamed:@"Img_Bn_BgScores"];
    ScoreQuizCustomButton = [[CustomButton alloc]initWithFrame:CGRectMake(11,293,166,39)];
    [ScoreQuizCustomButton.view_BnPatch setFrame:CGRectMake(3, 3, 160, 33)];
    [ScoreQuizCustomButton.btn setFrame:CGRectMake(0,0,166,39)];
    [ScoreQuizCustomButton.btn setTitle:@"Scores by Quiz" forState:UIControlStateNormal];
    ScoreQuizCustomButton.btn.tag=1;
    [ScoreQuizCustomButton.btn addTarget:self action:@selector(OnScoreByTapped:) forControlEvents:UIControlEventTouchUpInside];
    [ScoreQuizCustomButton.btn setBackgroundImage:img forState:UIControlStateNormal];
    [View_Result  addSubview:ScoreQuizCustomButton];
    
    ScoreTopicCustomButton = [[CustomButton alloc]initWithFrame:CGRectMake(188,293,166,39)];
    [ScoreTopicCustomButton.view_BnPatch setFrame:CGRectMake(3, 3, 160, 33)];
    [ScoreTopicCustomButton.btn setFrame:CGRectMake(0,0,166,39)];
    ScoreTopicCustomButton.btn.tag=2;
    [ScoreTopicCustomButton.btn addTarget:self action:@selector(OnScoreByTapped:) forControlEvents:UIControlEventTouchUpInside];
    [ScoreTopicCustomButton.btn setBackgroundImage:img forState:
     UIControlStateNormal];
    [ScoreTopicCustomButton.btn setTitle:@"Scores by Topic" forState:UIControlStateNormal];
    [View_Result  addSubview:ScoreTopicCustomButton];
    
    ScoreCustomButton = [[CustomButton alloc]initWithFrame:CGRectMake(365,293,166,39)];
    [ScoreCustomButton.view_BnPatch setFrame:CGRectMake(3, 3, 160, 33)];
    [ScoreCustomButton.btn setFrame:CGRectMake(0,0,166,39)];
    [ScoreCustomButton.btn setBackgroundImage:img forState:UIControlStateNormal];
    [ScoreCustomButton.btn setTitle:@"Delete Scores" forState:UIControlStateNormal];
    [ScoreCustomButton.btn addTarget:self action:@selector(OnDeleteAllTapped:) forControlEvents:UIControlEventTouchUpInside];
    [View_Result  addSubview:ScoreCustomButton];
    
}
-(void)fnSetScore
{
    NSMutableArray *questions = [db fnGetQuizScoreOfAllChapter];
    
    int total = [questions count];
    
    QuizScore *objQuizScore = [[QuizScore alloc] init];
    
    objQuizScore.intMissedQuestion=0;
    objQuizScore.intcorrectAns=0;
    objQuizScore.intIncorrectAns=0;
    objQuizScore.intTotalScore=0;
    
    int totalSubmitedAnswer = 0;
    for (int i =0; i< total; i++) {
        Questions *objQuestion = [questions objectAtIndex:i];
        
        int val = objQuestion.intAnswered;
        
        if (val == 0) {
            objQuizScore.intMissedQuestion++;
        }
        else if (val == 1) {
            totalSubmitedAnswer++;
            objQuizScore.intcorrectAns++;
        }
        else if (val == 2) {
            totalSubmitedAnswer++;
            objQuizScore.intIncorrectAns++;
        }
    }

    if (objQuizScore.intcorrectAns==0) {
        objQuizScore.intTotalScore=0;
    }
    else{
        objQuizScore.intTotalScore = ( objQuizScore.intcorrectAns * 100 ) / total ;
    }
    lblTotalQuestion.text = [NSString stringWithFormat:@"%d", total];
    
    lblAnsSubmited.text = [NSString stringWithFormat:@"%d", objQuizScore.intcorrectAns+objQuizScore.intIncorrectAns];
    
    lblCorrect.text = [NSString stringWithFormat:@"%d", objQuizScore.intcorrectAns];
    
    lblIncorrect.text = [NSString stringWithFormat:@"%d", objQuizScore.intIncorrectAns];
    
    lblPerformance.text = [NSString stringWithFormat:@"%d%%", objQuizScore.intTotalScore];
}
//-----------------------------------------------
#pragma mark - Button Actions
//-----------------------------------------
-(IBAction)onBack:(id)sender
{
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)OnScoreByTapped:(UIButton *)sender
{
    ByQuizTopicViewController *byQuizTopicViewController = [[ByQuizTopicViewController alloc]initWithNibName:@"ByQuizTopicViewController" bundle:nil];
    if (sender.tag==1) {
         byQuizTopicViewController.int_modebyTopicQuiz = 1;
        [db fnGetQuizScoreData];
        
        if (quizscoreDbData.count == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.title = @"Message";
            alertView.message = @"You have not taken any quiz.";
            [alertView addButtonWithTitle:@"OK"];
            [alertView show];
            return;
        }
        else {
            [self.navigationController pushViewController:byQuizTopicViewController animated:YES];
        }
        
    }
    else
    {
        byQuizTopicViewController.int_modebyTopicQuiz=2;
        [self.navigationController pushViewController:byQuizTopicViewController animated:YES];
        
    }
   

}

-(IBAction)OnDeleteAllTapped:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.title = TITLE_MSG;
    alertView.delegate = self;
    alertView.message = MSG_DELETE_ALLSCORE;
    [alertView addButtonWithTitle:@"Yes"];
    [alertView addButtonWithTitle:@"No"];
    [alertView show];
}
//-----------------------------------------

#pragma mark - AlertView
//-----------------------------------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	
    if([title isEqualToString:@"Yes"])
    {
        [db fnDeleteAllScore];
        [self fnSetScore];
    }
}
//-----------------------------------------



#pragma mark - Rotations
//-----------------------------------------
- (BOOL) shouldAutorotate
{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations
{
    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        return NO;
    }
    
    NSUInteger mask= UIInterfaceOrientationMaskPortrait;
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft){
        [self fn_Landscape];
        
        mask  |= UIInterfaceOrientationMaskLandscapeLeft;
        
    }
    else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        [self fn_Landscape];
        mask |= UIInterfaceOrientationMaskLandscapeRight;
        
	}
	else if(interfaceOrientation==UIInterfaceOrientationPortrait){
        [self fn_Portrait];
        mask  |=UIInterfaceOrientationMaskPortraitUpsideDown;
        
	}
	else {
        [self fn_Portrait];
        mask  |=UIInterfaceOrientationMaskPortrait;
        
	}
    return UIInterfaceOrientationMaskAll;
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait ) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown ))
    {
        [self fn_Portrait];
        
    }
    
    else if(( [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft )||([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight ))
        
    {
        [self fn_Landscape];
        
    }
    
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
   
    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        return NO;
    }
    if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft){
        [self fn_Landscape];
        return YES;
    }
    else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
		[self fn_Landscape];
        return YES;
	}
	else if(interfaceOrientation==UIInterfaceOrientationPortrait){
		[self fn_Portrait];
        return YES;
	}
	else {
        [self fn_Portrait];
        return YES;
	}
    
	return YES;
}

-(void)fn_Portrait
{
    [Img_bg setImage:[UIImage imageNamed:@"Img_View_TextureBg_P"]];
    [Img_bg  setFrame:CGRectMake(0 , 0 ,768,960)];
    [View_Result  setFrame:CGRectMake(113  , 305 , 542  ,350)];
    [Title setFrame:CGRectMake(184, 0, 400, 44)];
}
-(void)fn_Landscape
{
    [Img_bg setImage:[UIImage imageNamed:@"Img_View_TextureBg"]];
    [Img_bg  setFrame:CGRectMake(0 , 0 ,1024,704)];
    [View_Result  setFrame:CGRectMake(241  , 177 , 542  ,350)];
    [Title setFrame:CGRectMake(312, 0, 400, 44)];
    
}
//-----------------------------------------
@end
