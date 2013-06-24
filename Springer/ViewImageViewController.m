//
//  ViewImageViewController.m
//  Springer
//
//  Created by PUN-MAC-09 on 19/06/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "ViewImageViewController.h"
NSString *str;
@interface ViewImageViewController ()
{
   IBOutlet UIView *viewZoom;
   IBOutlet UIView *ViewAnimation;
   IBOutlet UIImage *img_Original;
  IBOutlet UIImageView *imgview1;
   IBOutlet UIButton *bnClose;
    IBOutlet UIView *bg;
    UIImage *imgView;
    
 }
@end

@implementation ViewImageViewController
@synthesize imgname;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    img_Original=imgView;
   
    imgname=[[NSString alloc]init];
    
    imgView=[UIImage imageNamed:imgname];
    [self fnCreateZoomImage];
    [self imageAnimation];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fnSetData:(NSString *)img
    {
        imgname=img;
        str=imgname;
    }
-(void)fnCreateZoomImage
{
    imgView=[UIImage imageNamed:str];
    self.view.backgroundColor = COLOR_BG_BLACK_04;
    
    float x_ = ( self.view.frame.size.width - imgView.size.width ) / 2;
    float y_ = ( self.view.frame.size.height - imgView.size.height ) / 2;
    
    
    
    NSLog(@"%f",imgView.size.width);
    NSLog(@"%f",imgView.size.height);
    float Height;
    float wedth;
    
    Height=imgView.size.height;
    wedth=imgView.size.width;
    if (imgView.size.width > self.view.frame.size.width || imgView.size.height > self.view.frame.size.height) {
        x_=30;
        y_=50;
        Height=self.view.frame.size.height-100;
        wedth=self.view.frame.size.width-60;
        
    }
    [ViewAnimation setFrame:CGRectMake(x_-15, y_-15,wedth+40, Height+30)];
    ViewAnimation.backgroundColor = COLOR_CLEAR;
    [viewZoom addSubview:ViewAnimation];
    
    
    
   
    bg.backgroundColor = COLOR_WHITE;
    [bg setFrame:CGRectMake(0, 20, wedth+20, Height+20)];
    //    bg.layer.cornerRadius = 5;
    [ViewAnimation addSubview:bg];
    
    UIImage *imgClose = [UIImage imageNamed:@"Img_Bn_SharePopupClose.png"];
    
//   UIImageView *imgView1 = [[UIImageView alloc] initWithImage:img_Original];
    imgview1.image=[UIImage imageNamed:str];
    
    [imgview1 setFrame:CGRectMake(10 ,30,wedth, Height)];
    [ViewAnimation addSubview:imgview1];
    
    if (imgView.size.width > self.view.frame.size.width || imgView.size.height > self.view.frame.size.height) {
        imgview1.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    NSLog(@"%f",imgView.size.width);
    NSLog(@"%f",imgView.size.height);
    
//    UIButton *bnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    bnClose.frame = CGRectMake(wedth+5,5, imgClose.size.width+10, imgClose.size.height+10);
    [bnClose setImage:imgClose forState:UIControlStateNormal];
    [bnClose addTarget:self action:@selector(fnAnimateZoomOutImage) forControlEvents:UIControlEventTouchUpInside];
    bnClose.exclusiveTouch = YES;
    [ViewAnimation addSubview:bnClose];
    
//    viewZoom.exclusiveTouch = YES;
    [self.view addSubview:viewZoom];
    
    
}
-(void)fnAnimateZoomOutImage
{
    [md Fn_SubZoomImagePopup];
}
-(void)imageAnimation
{
    //Animation
    
    CGAffineTransform trans = CGAffineTransformScale(ViewAnimation.transform, 0.01, 0.01);
    ViewAnimation.transform = trans;	// do it instantly, no animation
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         ViewAnimation.transform = CGAffineTransformScale(ViewAnimation.transform, 100.0, 100.0);
                     }
                     completion:nil];
    
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
    [self.view setFrame:CGRectMake(0,0, 768, 1024)];
    
    [self fnCreateZoomImage];
       
}
-(void)fn_Landscape
{
    [self.view setFrame:CGRectMake(0, 0, 1024, 768)];

    [self fnCreateZoomImage];
   
}
@end
