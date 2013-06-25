//
//  MenuViewController.m
//  Springer
//
//  Created by PUN-MAC-012 on 02/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "MenuViewController.h"
#import "CreateQuizViewController.h"
#import "CreateBrouseViewController.h"
#import "QuizScoreViewController.h"
#import "CustomRightBarItem.h"
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>
#import "CustomTitle.h"

//Comment

@interface MenuViewController ()
{
    IBOutlet UIButton *btnBrowse;
    IBOutlet UIButton *btnQuiz;
    IBOutlet UIButton *btnScore;
    IBOutlet UIButton *btnFacebook;
    IBOutlet UIButton *btnTwitter;
    IBOutlet UIButton *btnLinkedin;
    IBOutlet UIButton *btnPinterest;
    IBOutlet UIButton *btnGooglePlus;
    
    IBOutlet UIImageView *imgViewBg;
    IBOutlet UIImageView *imgViewShare;
    IBOutlet UIImageView *imgViewNavigationBar;
    
   IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblBrowse;
    IBOutlet UILabel *lblQuiz;
    IBOutlet UILabel *lblScore;
    IBOutlet UILabel *lblBrowsetxt;
    IBOutlet UILabel *lblQuiztxt;
    IBOutlet UILabel *lblScoretxt;
    IBOutlet UILabel *lblShare;
    UIView *shareview;
    UIView *ViewAnimation;

    
    UIImageView *img_ShareBg;
    UIWebView *webshare;
    UIButton *btn_closeshare;
    
    CustomRightBarItem *customRightBar;
//    CustomTitle *lblTitle;
    
    IBOutlet UIWebView *webViewPinterest;
    IBOutlet UIView *view_Pinterest;
    IBOutlet UIView *view_background;
    
    NSString *scoreMsg;
}

-(void)fnSetFontColor;
-(void)fnSetVariables;
-(void)fnSetNavigationItems;
-(void)fnRotatePortrait;
-(void)fnRotateLandscape;

-(IBAction)onBrowseTapped:(id)sender;
-(IBAction)onQuizTapped:(id)sender;
-(IBAction)onScoreTapped:(id)sender;
-(IBAction)Bn_Facebook_Tapped:(id)sender;
-(IBAction)Bn_Twitter_Tapped:(id)sender;
-(IBAction)Bn_linkedin_Tapped:(id)sender;
-(IBAction)Bn_Pinterest_Tapped:(id)sender;
-(IBAction)closeWebVIew:(id)sender;

@end

@implementation MenuViewController
static NSString * const kClientId = @"430298569116.apps.googleusercontent.com";

#pragma mark - Defaults
//-----------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    self.navigationController.navigationBarHidden = YES;
    
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
    // Do any additional setup after loading the view from its nib.
    
    [self fnSetFontColor];
    [self fnSetVariables];
    [self fnSetNavigationItems];    
//    [self googlePlus];
    [self fn_setShareView];
    
    
}
-(void)fn_setShareView
{
    shareview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [self.view addSubview:shareview];
    
    shareview.backgroundColor=COLOR_BG_BLACK_04;
    ViewAnimation=[[UIView alloc]initWithFrame:CGRectMake(50, 50, 500, 500)];
    [shareview addSubview:ViewAnimation];
    
    webshare=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 500, 500)];
    webshare.scrollView.bounces = NO;
    webshare.backgroundColor = COLOR_BG_BLACK_04;
    webshare.scalesPageToFit = YES;
    [ViewAnimation addSubview:webshare];
    btn_closeshare =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_closeshare setImage:[UIImage imageNamed:@"Img_Bn_SharePopupClose.png"] forState:UIControlStateNormal];
    btn_closeshare.frame=CGRectMake(37, 30,50, 50);
    [btn_closeshare addTarget:self action:@selector(closeShare) forControlEvents:UIControlEventTouchUpInside];
    
    [ViewAnimation addSubview:btn_closeshare];
    
    shareview.hidden=YES;
}





- (void)viewDidUnload
{
    btnBrowse = nil;
    btnQuiz = nil;
    btnScore = nil;
    btnFacebook = nil;
    btnTwitter = nil;
    btnLinkedin = nil;
    btnPinterest = nil;
    btnGooglePlus = nil;
    
    imgViewBg = nil;
    imgViewShare = nil;
    imgViewNavigationBar = nil;
    
    lblTitle = nil;
    lblBrowse = nil;
    lblQuiz = nil;
    lblScore = nil;
    lblBrowsetxt = nil;
    lblQuiztxt = nil;
    lblScoretxt = nil;
    lblShare = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-----------------------------------------

#pragma mark - Normal Functions
//-----------------------------------------
-(void)fnSetFontColor
{
    self.view.backgroundColor = COLOR_BG_BLUE;
    self.navigationController.navigationBar.backgroundColor = COLOR_BG_BLUE;
    
//    lblTitle.textColor = COLOR_WHITE;
    lblBrowse.textColor = COLOR_RED;
    lblQuiz.textColor = COLOR_RED;
    lblScore.textColor = COLOR_RED;
    
    lblBrowse.textAlignment=UITextAlignmentCenter;
    lblQuiz.textAlignment=UITextAlignmentCenter;
    lblScore.textAlignment=UITextAlignmentCenter;

    
    
    lblBrowsetxt.textColor = COLOR_BLACK_Rgb;
    lblQuiztxt.textColor = COLOR_BLACK_Rgb;
    lblScoretxt.textColor = COLOR_BLACK_Rgb;
    lblShare.textColor = COLOR_TEXT_WHITE_Rgb;
    
//    lblTitle.font = FONT_Helvetica_bold_20;
    lblBrowse.font = FONT_Helvetica_neue_medium_20;
    lblQuiz.font = FONT_Helvetica_neue_medium_20;
    lblScore.font = FONT_Helvetica_neue_medium_20;
    lblBrowsetxt.font = FONT_Trebuchet_MS_13;
    lblQuiztxt.font = FONT_Trebuchet_MS_13;
    lblScoretxt.font = FONT_Trebuchet_MS_13;
    lblShare.font = FONT_Helvetica_17;

    
//    lblTitle.shadowColor = [UIColor blackColor];
//    lblTitle.shadowOffset = CGSizeMake(0, -1);
    
    //Allignment
    lblBrowsetxt.textAlignment = UITextAlignmentCenter;
    lblQuiztxt.textAlignment = UITextAlignmentCenter;
    lblScoretxt.textAlignment = UITextAlignmentCenter;
    
}

-(void)fnSetVariables
{
    //self.navigationController.navigationBar.hidden = YES;
    
    
//    [lblTitle setText:@"Ultimate Q&A Review for the Neurology Boards"];
    
    scoreMsg = @"Score: 50%";
    
    lblBrowsetxt.text = @"Browse questions by topic, view answers and review rationales.";
    lblQuiztxt.text = @"Create a custom quiz by selecting question types and topics. Your score will be saved.";
    lblScoretxt.text = @"Review your overall performance, scores by topic, and scores by quiz.";
}

-(void)fnSetNavigationItems
{
//    customRightBar = [[CustomRightBarItem alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
//    
//    [self.view addSubview:customRightBar];
//    self.navigationItem.title=@"Springer Quiz";
    
    customRightBar = [[CustomRightBarItem alloc] initWithFrame:CGRectMake(0, 0, 123, 44)];
    UIBarButtonItem *btnBar2 = [[UIBarButtonItem alloc] initWithCustomView:customRightBar];
    self.navigationItem.rightBarButtonItem = btnBar2;
    
    
    lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 600, 44)];
    lblTitle.text=@"Ultimate Q&A Review for the Neurology Boards";
    lblTitle.textAlignment=UITextAlignmentCenter;
    lblTitle.backgroundColor=[UIColor clearColor];
   
    lblTitle.textColor = COLOR_WHITE;
    lblTitle.font = FONT_Helvetica_bold_20;
    lblTitle.shadowColor = [UIColor blackColor];
    lblTitle.shadowOffset = CGSizeMake(0, -1);
    
    self.navigationItem.titleView=lblTitle;
    
}

-(void)postToPinterest
{
    NSString *htmlString = [self generatePinterestHTML];
    NSLog(@"Generated HTML String:%@", htmlString);
    webViewPinterest.backgroundColor = [UIColor clearColor];
    webViewPinterest.opaque = NO;
    if ([webViewPinterest isHidden]) {
        [webViewPinterest setHidden:NO];
    }
    [webViewPinterest loadHTMLString:htmlString baseURL:nil];
}

-(NSString*) generatePinterestHTML
{
    NSString *description = @"Post your description here";
        NSString *sUrl = [NSString stringWithFormat:@"http://www.alkalima.com/images/08-02/nature.jpg"];
    NSLog(@"URL:%@", sUrl);
    NSString *protectedUrl = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)sUrl, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSLog(@"Protected URL:%@", protectedUrl);
    NSString *imageUrl = [NSString stringWithFormat:@"\"%@\"", sUrl];
    NSString *buttonUrl = [NSString stringWithFormat:@"\"http://pinterest.com/pin/create/button/?url=www.flor.com&media=%@&description=%@\"", protectedUrl, description];
    
    NSMutableString *htmlString = [[NSMutableString alloc] initWithCapacity:1000];
    [htmlString appendFormat:@"<html> <body>"];
    [htmlString appendFormat:@"<p align=\"center\"><a href=%@ class=\"pin-it-button\" count-layout=\"horizontal\"><img border=\"0\" src=\"http://assets.pinterest.com/images/PinExt.png\" title=\"Pin It\" /></a></p>", buttonUrl];
    [htmlString appendFormat:@"<p align=\"center\"><img width=\"400px\" height = \"400px\" src=%@></img></p>", imageUrl];
    [htmlString appendFormat:@"<script type=\"text/javascript\" src=\"//assets.pinterest.com/js/pinit.js\"></script>"];
    [htmlString appendFormat:@"</body> </html>"];
    return htmlString;
    
}
//-----------------------------------------


#pragma mark - Button Actions
//-----------------------------------------
-(IBAction)closeShare
{
    NSString *urlAddress = @"";
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webshare loadRequest:requestObj];

    shareview.hidden=YES;
    
    self.navigationController.navigationBar.userInteractionEnabled=YES;
    
}

-(void)ShareAnimaton
{
    CGAffineTransform trans = CGAffineTransformScale(ViewAnimation.transform, 0.01, 0.01);
    ViewAnimation.transform = trans;	// do it instantly, no animation
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         ViewAnimation.transform = CGAffineTransformScale(ViewAnimation.transform, 100.0, 100.0);
                     }
                     completion:nil];
}
-(IBAction)Bn_Facebook_Tapped:(id)sender
{
    self.navigationController.navigationBar.userInteractionEnabled=NO;
    
    shareview.hidden=NO;

    NSString *urlAddress = @"https://www.facebook.com/sharer/sharer.php?u=www.demosmedpub.com/prod.aspx?prod_id=9781620700020";
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webshare loadRequest:requestObj];

    [self ShareAnimaton];

}

-(IBAction)Bn_Twitter_Tapped:(id)sender
{
   
    self.navigationController.navigationBar.userInteractionEnabled=NO;
    
    shareview.hidden=NO;

    NSString *urlAddress = @"http://twitter.com/home?status=I'm+using+the+Ultimate+Review+for+the+Neurology+Boards+App+www.demosmedpub.com/prod.aspx?prod_id=9781620700020";
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webshare loadRequest:requestObj];
    
    [self ShareAnimaton];

}

-(IBAction)Bn_linkedin_Tapped:(id)sender
{
   
    self.navigationController.navigationBar.userInteractionEnabled=NO;
    
    shareview.hidden=NO;

    NSString *urlAddress = @"https://www.linkedin.com/cws/share?url=www.demosmedpub.com/prod.aspx?prod_id=9781620700020";
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webshare loadRequest:requestObj];
    [self ShareAnimaton];

}

-(IBAction)Bn_Pinterest_Tapped:(id)sender
{
    
    self.navigationController.navigationBar.userInteractionEnabled=NO;
    
    shareview.hidden=NO;

    NSString *urlAddress = @"http://pinterest.com/pin/create/button/?url=www.demosmedpub.com/prod.aspx?prod_id=9781620700020";
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webshare loadRequest:requestObj];
    [self ShareAnimaton];

    
}
-(IBAction)GooglePlus_tapped:(id)sender
{
    
    self.navigationController.navigationBar.userInteractionEnabled=NO;
    
    shareview.hidden=NO;

    NSString *urlAddress = @"https://plus.google.com/share?url=www.demosmedpub.com/prod.aspx?prod_id=9781620700020";
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webshare loadRequest:requestObj];
    [self ShareAnimaton];

}

-(IBAction)closeWebVIew:(id)sender
{
    [view_Pinterest removeFromSuperview];
     view_background.hidden = YES;
}

-(IBAction)onBrowseTapped:(id)sender
{
    
    CreateBrouseViewController  *createBrouseViewController = [[CreateBrouseViewController alloc] initWithNibName:@"CreateBrouseViewController" bundle:nil];
    // self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:createBrouseViewController animated:YES];
}

-(IBAction)onQuizTapped:(id)sender
{
    CreateQuizViewController  *createQuizViewController = [[CreateQuizViewController alloc] initWithNibName:@"CreateQuizViewController_iPad" bundle:nil];
    // self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:createQuizViewController animated:YES];
}

-(IBAction)onScoreTapped:(id)sender
{
    QuizScoreViewController  *quizScoreViewController = [[QuizScoreViewController alloc] initWithNibName:@"QuizScoreViewController_Ipad" bundle:nil];
    // self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:quizScoreViewController animated:YES];

//    QuizScoreViewController  *quizScoreViewController = [[QuizScoreViewController alloc] initWithNibName:@"QuizScoreViewController_Ipad" bundle:nil];
//    // self.navigationController.navigationBarHidden = NO;
//    [self.navigationController pushViewController:quizScoreViewController animated:YES];
}
//-----------------------------------------


# pragma mark - Webview Delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    view_Pinterest.hidden=NO;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         view_Pinterest.transform = CGAffineTransformIdentity;
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
          {
              view_Pinterest.transform = CGAffineTransformMakeScale(0.7, 0.7);
          }
                          completion:^(BOOL finished)
          {
              [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
               {
                   view_Pinterest.transform = CGAffineTransformIdentity;
               }
                               completion:^(BOOL finished)
               {
                   
               }];
              
          }];
     }];
    
}


#pragma mark - Rotations
//-----------------------------------------

-(BOOL) shouldAutorotate
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
	else if(interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown){
        [self fnRotatePortrait];
        return YES;
	}
    
	return YES;
}

-(void)fnRotatePortrait
{
    self.view.frame = CGRectMake(0, 0, 768, 1024);
    
    [imgViewNavigationBar setImage:[UIImage imageNamed:@"Img_View_NavigationBar_P.png"]];
    [imgViewNavigationBar setFrame:CGRectMake(0, 0, 768, 45)];
    [imgViewBg setImage:[UIImage imageNamed:@"Img_View_HomeBg_P.png"]];
    [imgViewBg setFrame:CGRectMake(0, 0, 768, 960)];
    
    [btnBrowse setImage:[UIImage imageNamed:@"Img_Bn_HomeBrowse_P.png"] forState:UIControlStateNormal];
    [btnBrowse setFrame:CGRectMake(84, 66, 601, 203)];
    
    [btnQuiz setImage:[UIImage imageNamed:@"Img_Bn_HomeQuiz_P.png"] forState:UIControlStateNormal];
    [btnQuiz setFrame:CGRectMake(84, 272, 601, 203)];
    
    
    [btnScore setImage:[UIImage imageNamed:@"Img_Bn_HomeScores_P.png"] forState:UIControlStateNormal];
    [btnScore setFrame:CGRectMake(84, 478, 601, 203)];
    
    [lblBrowse setFrame:CGRectMake(290, 138, 300, 24)];
    [lblQuiz setFrame:CGRectMake(290, 336, 300, 24)];
    [lblScore setFrame:CGRectMake(290, 550, 300, 24)];
    
    
    [lblBrowsetxt setFrame:CGRectMake(322, 150, 235, 60)];
    [lblQuiztxt setFrame:CGRectMake(322, 348, 235, 76)];
    [lblScoretxt setFrame:CGRectMake(322, 562, 235, 60)];
    
    
    [imgViewShare setFrame:CGRectMake(259, 838, 251, 39)];
    [lblShare setFrame:CGRectMake(275, 845, 46, 21)];
    [btnFacebook setFrame:CGRectMake(327, 845, 25, 25)];
    [btnTwitter setFrame:CGRectMake(365, 845, 25, 25)];
    [btnLinkedin setFrame:CGRectMake(402, 845, 25, 25)];
    [btnPinterest setFrame:CGRectMake(439, 845, 25, 25)];
    [btnGooglePlus setFrame:CGRectMake(476, 845, 25, 25)];
    
    [lblTitle setFrame:CGRectMake(149, 0, 470, 44)];

//    [customRightBar setFrame:CGRectMake(638, 0, 130, 44)] ;
    
    ////
    [view_background setFrame:CGRectMake(0, 0, 768, 1004)];
    [view_Pinterest setFrame:CGRectMake(154, 211, 460, 602)];
    [img_ShareBg setImage:[UIImage imageNamed:@"Img_SharePopupBg_P"]];
    [img_ShareBg setFrame:CGRectMake(0, 0, 460, 602)];
    [webViewPinterest  setFrame:CGRectMake(12, 12, 436, 578)];
    
    [shareview setFrame:CGRectMake(0, 0, 768, 1024)];
    [ViewAnimation setFrame:CGRectMake(29, 5,710, 930)];
    [webshare setFrame:CGRectMake(10, 10,690, 920)];
    btn_closeshare.frame=CGRectMake(680, -10, 40, 40);    
}

-(void)fnRotateLandscape
{
    
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    
    [imgViewBg setImage:[UIImage imageNamed:@"Img_View_HomeBg.png"]];
    [imgViewBg setFrame:CGRectMake(0, 2, 1024, 704)];
    
    
    [btnBrowse setImage:[UIImage imageNamed:@"Img_Bn_HomeBrowse.png"] forState:UIControlStateNormal];
    [btnBrowse setFrame:CGRectMake(68, 102, 300, 350) ];
    
    [btnQuiz setImage:[UIImage imageNamed:@"Img_Bn_HomeQuiz.png"] forState:UIControlStateNormal];
    [btnQuiz setFrame:CGRectMake(366, 102, 300, 350)];
    
    
    [btnScore setImage:[UIImage imageNamed:@"Img_Bn_HomeScores.png"] forState:UIControlStateNormal];
    [ btnScore setFrame:CGRectMake(664, 102, 300, 350)];
    
    [lblBrowse setFrame:CGRectMake(68, 298, 300, 24)];
    [lblQuiz setFrame:CGRectMake(366, 298, 300, 24)];
    [lblScore setFrame:CGRectMake(664, 298, 300, 24)];
    
    [lblBrowsetxt setFrame:CGRectMake(100, 310, 230, 60)];
    [lblQuiztxt setFrame:CGRectMake(414, 310, 200, 74)];
    [lblScoretxt setFrame:CGRectMake(700, 310, 230, 60)];
    
    
    [imgViewShare setFrame:CGRectMake(387, 609, 251, 39)];
    [lblShare setFrame:CGRectMake(402, 617, 46, 21)];
    [btnFacebook setFrame:CGRectMake(455, 616, 25, 25)];
    [btnTwitter setFrame:CGRectMake(493, 616, 25, 25)];
    [btnLinkedin setFrame:CGRectMake(530, 616, 25, 25)];
    [btnPinterest setFrame:CGRectMake(567, 616, 25, 25)];
    [btnGooglePlus setFrame:CGRectMake(604, 616, 25, 25)];
    
    [lblTitle setFrame:CGRectMake(277, 0, 470, 44)];
    
    // [customRightBar setFrame:CGRectMake(894, 0, 130, 44)] ;
    
    //
    [view_background setFrame:CGRectMake(0, 0,1024, 748)];
    [view_Pinterest setFrame:CGRectMake(205, 150, 614, 448)];
    [img_ShareBg setImage:[UIImage imageNamed:@"Img_SharePopupBg"]];
    [img_ShareBg setFrame:CGRectMake(0, 0,  614, 448)];
    [webViewPinterest  setFrame:CGRectMake(12, 12, 590, 424)];
    
    [shareview setFrame:CGRectMake(0, 0, 1024, 768)];
    [ViewAnimation setFrame:CGRectMake(42,5,940, 680)];
    [webshare setFrame:CGRectMake(10,10,920, 670)];
    btn_closeshare.frame=CGRectMake(910, -10, 40, 40);
    
}
//-----------------------------------------

@end
