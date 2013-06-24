//
//  HelpViewController.m
//  Springer
//
//  Created by systems pune on 07/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
{
    IBOutlet UIButton *bn_Close;
    IBOutlet UIImageView *img_bg;
    IBOutlet UIView *view_Help;
    IBOutlet UILabel *lbl_Help;
    IBOutlet UIWebView *Web_Help;
    IBOutlet UIView *ViewAnimation;

    
}
@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *webPagePath = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"Help" ofType:@"html"]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:webPagePath])
    {
        NSURL *loadUrl = [NSURL fileURLWithPath:webPagePath];
        
        [Web_Help loadRequest:[NSURLRequest requestWithURL:loadUrl]];
    }
    // Do any additional setup after loading the view from its nib.
    lbl_Help.text =@"HELP";
    [self fnSetFontColor];
    if (DEVICE_VERSION>CURRENT_VERSION) {
         Web_Help.scrollView.bounces = NO;
    }
    else
    {
        [(UIScrollView *)[[Web_Help subviews] lastObject] setBounces:NO];
    }
    
    //Animation
    
    CGAffineTransform trans = CGAffineTransformScale(ViewAnimation.transform, 0.01, 0.01);
    ViewAnimation.transform = trans;	// do it instantly, no animation
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         ViewAnimation.transform = CGAffineTransformScale(ViewAnimation.transform, 100.0, 100.0);
                     }
                     completion:nil];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)fnSetFontColor
{
    //Color
    [Web_Help setBackgroundColor:COLOR_CLEAR];
    Web_Help.opaque = NO;
    lbl_Help.textColor = COLOR_TEXT_WHITE;
    lbl_Help.font = FONT_Helvetica_20;
    lbl_Help.shadowColor = [UIColor blackColor];
    lbl_Help.shadowOffset = CGSizeMake(0, 1.0);
    self.view.backgroundColor = COLOR_BG_BLACK_04;
    //[self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    
    //

}

-(IBAction)Bn_close_Tapped:(id)sender
{
    [md Fn_SubHelpViewPopup];
    
}


#pragma mark - Rotations
//-----------------------------------------
-(void)fn_Portrait
{
    self.view.frame = CGRectMake(0, -44, 768, 1024);
    
    //[view_Help setFrame:CGRectMake(60,100,640,743)];
   [ ViewAnimation setFrame:CGRectMake(35,123,700,802)];
    [img_bg setFrame:CGRectMake(0,0,700,802)];
    [img_bg setImage:[UIImage imageNamed:@"Img_View_HelpBg_P.png"]];
    [Web_Help setFrame:CGRectMake(0,44,700,763)];
    [bn_Close setFrame:CGRectMake(659,-1,44,44)];
    [lbl_Help setFrame:CGRectMake(20,10,42,21)];
     [Web_Help reload];
    
}
-(void)fn_Landscape
{
    self.view.frame = CGRectMake(0, -44, 1024, 768);
    
    //[view_Help setFrame:CGRectMake(70,40,875,659)];
    [ ViewAnimation  setFrame:CGRectMake(44,64,937,662)];
    [img_bg setFrame:CGRectMake(0,0,937,662)];
    [img_bg setImage:[UIImage imageNamed:@"Img_View_HelpBg.png"]];
    [bn_Close setFrame:CGRectMake(896,-1,44,44)];
    [Web_Help setFrame:CGRectMake(1,46,937,610)];
    [lbl_Help setFrame:CGRectMake(19,9,42,21)];
     [Web_Help reload];
}


#pragma mark - WebView Delegate

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType
{
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
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

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft){
        [self fn_Landscape];
    }
    else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
		[self fn_Landscape];
        
	}
	else if(interfaceOrientation==UIInterfaceOrientationPortrait){
		[self fn_Portrait];
        
	}
	else {
        [self fn_Portrait];
        
	}
    
	return YES;
}

//---------------------------------------------------------
@end