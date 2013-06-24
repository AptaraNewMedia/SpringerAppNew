//
//  AppDelegate.h
//  Springer
//
//  Created by PUN-MAC-012 on 02/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;



- (void) Fn_AddMenu;
- (void) Fn_SubMenu;

- (void) Fn_AddBrowseQuestion;
- (void) Fn_SubBrowseQuestion;

- (void) Fn_AddCreateQuiz;
- (void) Fn_SubCreateQuiz;

- (void) Fn_AddScore;
- (void) Fn_SubScore;

- (void) Fn_ShowInfoViewPopup;
- (void) Fn_SubInfoViewPopup;

- (void) Fn_ShowHelpViewPopup;
- (void) Fn_SubHelpViewPopup;

- (void) Fn_AddNote:(Notes *)notes;
- (void) Fn_SetNoteIcons:(BOOL)flag;
- (void) Fn_SubNote;

-(void) Fn_CallPopupOrientaion;

-(void) Fn_ZoomImgWithView:(NSString *)view;
- (void) Fn_SubZoomImagePopup;

@end
