//
//  CustomRightBarItem.m
//  PathoPhys
//
//  Created by PUN-MAC-012 on 11/04/13.
//  Copyright (c) 2013 Aptara. All rights reserved.
//

#import "CustomRightBarItem.h"


@interface CustomRightBarItem()
{        
    UIPopoverController *infoPopup;
    UIPopoverController *notePopup;
}

@end

@implementation CustomRightBarItem

@synthesize btnhelp;
@synthesize btnInfo;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        btnhelp = [UIButton buttonWithType:UIButtonTypeCustom];
        btnhelp.backgroundColor = COLOR_CLEAR;
       
        btnhelp.frame = CGRectMake(89.0, 6.0, 34, 34);
        [btnhelp setImage:[UIImage imageNamed:@"Img_Bn_Help.png"] forState:UIControlStateNormal];
        [btnhelp addTarget:self action:@selector(onHelp:) forControlEvents:UIControlEventTouchUpInside];
        btnhelp.exclusiveTouch = YES;
        [self addSubview:btnhelp];
        
//        btnNote = [UIButton buttonWithType:UIButtonTypeCustom];
//        btnNote.backgroundColor = COLOR_CLEAR;
//        btnNote.frame = CGRectMake(40.0, 7.0, 30, 30);
//        [btnNote setImage:[UIImage imageNamed:@"img_topicon_note.png"] forState:UIControlStateNormal];
//        [btnNote addTarget:self action:@selector(onNote:) forControlEvents:UIControlEventTouchUpInside];
//        btnNote.exclusiveTouch = YES;
//        [self addSubview:btnNote];
        
        
        btnInfo = [UIButton buttonWithType:UIButtonTypeCustom];
        btnInfo.backgroundColor = COLOR_CLEAR;
        btnInfo.frame = CGRectMake(50.0, 6.0, 34, 34);
        [btnInfo setImage:[UIImage imageNamed:@"Img_Bn_Info.png"] forState:UIControlStateNormal];
        [btnInfo addTarget:self action:@selector(onInfo:) forControlEvents:UIControlEventTouchUpInside];
        btnInfo.exclusiveTouch = YES;
        [self addSubview:btnInfo];
        
       
          
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(IBAction)onHelp:(id)sender
{
    [md Fn_SubHelpViewPopup];
    [md Fn_ShowHelpViewPopup]; 
}

-(IBAction)onNote:(id)sender
{
    
}

-(IBAction)onInfo:(id)sender
{
    [md Fn_SubInfoViewPopup];
    [md Fn_ShowInfoViewPopup];
  }
@end
