//
//  CustomTitle.m
//  Springer
//
//  Created by PUN-MAC-09 on 22/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "CustomTitle.h"

@implementation CustomTitle
@synthesize LblTitle;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        LblTitle=[[UILabel alloc]init];
        LblTitle.frame=CGRectMake(0, 0, 400, 44);
        LblTitle.textAlignment=UITextAlignmentCenter;
        LblTitle.backgroundColor=[UIColor clearColor];
        LblTitle.text=@"abs";
        LblTitle.textColor = COLOR_WHITE;
        LblTitle.font = FONT_Helvetica_bold_20;
        LblTitle.shadowColor = [UIColor blackColor];
        LblTitle.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:LblTitle];

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

@end
