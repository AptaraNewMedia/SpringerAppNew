//
//  CustomLeftBarItem.m
//  PathoPhys
//
//  Created by PUN-MAC-012 on 16/04/13.
//  Copyright (c) 2013 Aptara. All rights reserved.
//

#import "CustomLeftBarItem.h"

@implementation CustomLeftBarItem
@synthesize btnBack;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
        btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBack.backgroundColor = COLOR_CLEAR;
        btnBack.frame = CGRectMake(5, 6, 73, 34);
       [btnBack setTitle:@"  Back" forState:UIControlStateNormal];
        btnBack.titleLabel.font = FONT_Helvetica_bold_12;
        btnBack.titleLabel.textColor =COLOR_TEXT_WHITE;
        btnBack.titleLabel.shadowColor = COLOR_BLACK;
        btnBack.titleLabel.shadowOffset = CGSizeMake(0, -1.0);
        [btnBack setBackgroundImage:[UIImage imageNamed:@"Img_Bn_Back.png"] forState:UIControlStateNormal];
//        [btnBack setBackgroundImage:[UIImage imageNamed:@"Img_Bn_Back.png"] forState:UIControlStateHighlighted];
        btnBack.exclusiveTouch = YES;
        [self addSubview:btnBack];
        
    }
    return self;
}

-(IBAction)onHome:(id)sender
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
