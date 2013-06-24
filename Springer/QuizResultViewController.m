//
//  QuizResultViewController.m
//  Springer1.1
//
//  Created by PUN-MAC-012 on 08/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "QuizResultViewController.h"
#import "QuizReviewViewController.h"
#import "CustomLeftBarItem.h"
#import "CustomRightBarItem.h"
#import "CustomButton.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTitle.h"
#import "QuizScore.h"


@interface QuizResultViewController ()
{
    CustomLeftBarItem *customLeftBar;
    CustomRightBarItem *customRightBar;
    CustomButton *ReviewCustomButton;
    CustomTitle *Title;

    QuizScore *objQuizScore;
    NSMutableArray *questiondData;
}
@end

@implementation QuizResultViewController

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
@synthesize lblTitle;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
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
//    self.title= @"Result";
    [super viewDidLoad];
    [self fnSetFontColor];
    [self fnSetNavigationItems];
    [self fnSetCustomButton];
    [self fnSetCornerRadius];


//    [self.view setBackgroundColor:[self colorWithHexString:@"005096"]];

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
    
    
    lblTitle.textColor = COLOR_TEXT_WHITE;
    lblTitle.font=  FONT_Trebuchet_MS_16;
    
    
    
}
-(void)fnSetCornerRadius
{
    CALayer *layer = [View_Result layer];
    [layer setCornerRadius:10.0];

    
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
    Title.LblTitle.text=@"Results";
    self.navigationItem.titleView=Title;
    
}
-(void)fnSetCustomButton
{
    
    ReviewCustomButton = [[CustomButton alloc]initWithFrame:CGRectMake(183,343 ,176,39)];
    [ReviewCustomButton.btn setTitle:@"Review Questions" forState:UIControlStateNormal];
    [ReviewCustomButton.btn addTarget:self action:@selector(onReview:) forControlEvents:UIControlEventTouchUpInside];
    [View_Result  addSubview:ReviewCustomButton];
    
    
    
}

-(void) fnSetData:(NSArray *)data AndScore:(QuizScore *)score
{
    questiondData = [data copy];
    objQuizScore = score;
}
//-----------------------------------------------
#pragma mark - Button Actions
//-----------------------------------------
-(IBAction)onBack:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
}

-(IBAction)onReview:(id)sender
{
    QuizReviewViewController *review = [[QuizReviewViewController alloc] initWithNibName:@"QuizReviewViewController_Ipad" bundle:nil];
    [review fnSetData:questiondData AndScore:objQuizScore FromQuizResult:1 AndParent:nil];
    [self.navigationController pushViewController:review animated:YES];
}


#pragma mark - Rotations
//-----------------------------------------
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
    [View_Result  setFrame:CGRectMake(113  , 280 , 542  ,400)];
    [Title setFrame:CGRectMake(184, 0, 400, 44)];
}
-(void)fn_Landscape
{
    [Img_bg setImage:[UIImage imageNamed:@"Img_View_TextureBg"]];
    [Img_bg  setFrame:CGRectMake(0 , 0 ,1024,704)];
    [View_Result  setFrame:CGRectMake(241  , 152 , 542  ,400)];
    [Title setFrame:CGRectMake(312, 0, 400, 44)];
    
}
//-----------------------------------------
@end
