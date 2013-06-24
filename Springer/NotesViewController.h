//
//  NotesViewController.h
//  Springer
//
//  Created by systems pune on 09/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Notes;

@interface NotesViewController : UIViewController<UITextViewDelegate>

-(void)fnSetData:(Notes *)notes;

-(void)fn_Portrait;
-(void)fn_Landscape;
@end
