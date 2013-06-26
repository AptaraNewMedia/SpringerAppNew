//
//  QuizResultViewController.m
//  Springer1.1
//
//  Created by PUN-MAC-012 on 08/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "ScoreQuizTopicViewController.h"

#import "CustomLeftBarItem.h"
#import "CustomRightBarItem.h"
#import "CustomButton.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTitle.h"





@interface ScoreQuizTopicViewController ()
{
    CustomLeftBarItem *customLeftBar;
    CustomRightBarItem *customRightBar;
    CustomButton *ScoreQuizCustomButton;
    CustomButton *ScoreTopicCustomButton;
    CustomTitle *Title;



}
@end

@implementation ScoreQuizTopicViewController

@synthesize lblAnsSubmited;
@synthesize lblCorrect;
@synthesize lblIncorrect;
@synthesize lblTitleAnsSubmited;
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
    self.title= @"Scores";
    [self fnSetFontColor];
    [self fnSetNavigationItems];
    [self fnSetCornerRadius];
    // Do any additional setup after loading the view from its nib.
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
    //Title.LblTitle.text=@"Score";
    Title.LblTitle.text=str_Bar_Title;
    self.navigationItem.titleView=Title;
    
}
-(void)fnSetCornerRadius
{
    CALayer *layer = [View_Result layer];
    [layer setCornerRadius:10.0];
    
        
}
//-----------------------------------------------
#pragma mark - Button Actions
//-----------------------------------------
-(IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Rotations
//-----------------------------------------

-(void)fn_Portrait
{
    [Img_bg setImage:[UIImage imageNamed:@"Img_View_TextureBg_P"]];
    [Img_bg  setFrame:CGRectMake(0 , 0 ,768,960)];
    [View_Result  setFrame:CGRectMake(113  , 334 , 542  ,292)];
    [Title setFrame:CGRectMake(184, 0, 400, 44)];
}
-(void)fn_Landscape
{
    [Img_bg setImage:[UIImage imageNamed:@"Img_View_TextureBg"]];
    [Img_bg  setFrame:CGRectMake(0 , 0 ,1024,704)];
    [View_Result  setFrame:CGRectMake(241  , 204 , 542  ,292)];
    [Title setFrame:CGRectMake(312, 0, 400, 44)];
    
}



- (BOOL) shouldAutorotate{
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
//-----------------------------------------
@end
