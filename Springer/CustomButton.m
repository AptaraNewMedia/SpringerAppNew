//
//  CustomButton.m
//  Springer
//
//  Created by systems pune on 10/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "CustomButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomButton
@synthesize btn,view_BnPatch;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        view_BnPatch = [[UIView alloc] initWithFrame:CGRectMake(3, 3, 170, 33)];
        CALayer *layer = [view_BnPatch layer];
        [layer setCornerRadius:6.0];
        self.view_BnPatch.backgroundColor = COLOR_RED;
        
        [self addSubview:view_BnPatch];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 176, 39);
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.textColor = COLOR_TEXT_WHITE;
        btn.titleLabel.shadowColor = [UIColor blackColor];
        btn.titleLabel.shadowOffset = CGSizeMake(0, 1.0);
        btn.titleLabel.font= FONT_Helvetica_neue_medium_15;
        [btn setBackgroundImage:[UIImage imageNamed:@"Img_Bn_Review.png"] forState:UIControlStateNormal];
        btn.exclusiveTouch = YES;
        [self addSubview:btn];
    }
    return self;
}




@end
