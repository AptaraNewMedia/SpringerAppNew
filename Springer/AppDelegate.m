//
//  AppDelegate.m
//  Springer
//
//  Created by PUN-MAC-012 on 02/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseQueries.h"
#import "XmlReader.h"
#import "MenuViewController.h"
#import "InfoViewController.h"
#import "HelpViewController.h"
#import "NotesViewController.h"
#import "Flurry.h"
#import "iRate.h"
#import "Notes.h"
#import "BrouseQuestionSetViewController.h"
#import "QuestionSetViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "ViewImageViewController.h"

@interface AppDelegate ()
{
    NotesViewController *notesViewController;
    InfoViewController *infoViewController;
    HelpViewController *helpViewController;
    
    ViewImageViewController *VImageViewController;
    
    
}
@end

@implementation AppDelegate
@synthesize navigationController;
#pragma mark - Defaults
//-----------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor clearColor];
    
    [self fnSetGlobalVariables];
    
    
    //
    if([UIScreen mainScreen].bounds.size.height == 568.0)
    {
        MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController_iPhone5" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    
    }else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController_iPhone" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
        
    } else {
        MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController_iPad" bundle:nil];        
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    }
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
        
    if (DEVICE_VERSION > CURRENT_VERSION)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else{
        
//     self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"Navigationbar.png"].CGImage;
//        self.navigationController.navigationBar.tintColor =COLOR_BG_BLUE;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Navigationbar.png"]];
        [self.navigationController.navigationBar addSubview:imageView];
         self.navigationController.navigationBar.tintColor =COLOR_BG_BLUE;
    }
    
//    self.navigationController.navigationBarHidden = YES;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - Defaults
//-----------------------------------------


#pragma mark - Normal Functions
//-----------------------------------------
-(void) fnSetGlobalVariables
{
    [Flurry startSession:@"9TG9PR22R6ZPSGPHXV2F"];    
    
    // initialize databse
    db = [[DatabaseQueries alloc] init];
    
    int xmlExist = [db fnCheckXMLCopiedInDatabase];
    if (xmlExist == 0) {
        // Read XML File
        XmlReader *xml = [[XmlReader alloc] init];
        NSMutableArray *chaptersData = [xml fnReadXml];
        if ([chaptersData count] > 0) {
            [db fnSetChapterQuestionData:chaptersData];
        }
        [db fnUPdateXMLexistinDatabase];
    }
    
    // get data of chapterlist
    [db fnGetChapterList];    
    
    // set current date
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    NSDate *currentDate = [NSDate date];
    CURRENT_DATE = [dateFormat stringFromDate:currentDate];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy HH:mm"];
    CURRENT_DATE_TIME = [dateFormat stringFromDate:currentDate];
    
    
    // set orientation 
    DEVICE_TYPE = [UIDevice currentDevice].model;
    DEVICE_VERSION = [[[UIDevice currentDevice] systemVersion] floatValue];
    CURRENT_VERSION=4.3;
    
    // set appdelegate object
    md = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (void)initialize
{
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    int reminderCount = [prefs integerForKey:@"ReminderCount"];
    NSUserDefaults *visit = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    int visitNumber = [visit integerForKey:@"VisitNumber"];
    NSLog(@"reminderCount=%d",reminderCount);
    if((reminderCount==1)||(reminderCount-visitNumber)==3)
    {
        [visit setInteger:reminderCount forKey:@"VisitNumber"];
        
        [iRate sharedInstance].applicationBundleID = @"com.charcoaldesign.rainbowblocks-free";
        [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
        
        //enable preview mode
        [iRate sharedInstance].previewMode = YES;
    }
    reminderCount++;
    NSLog(@"reminderCount=%d",reminderCount);
    [prefs setInteger:reminderCount forKey:@"ReminderCount"];
    reminderCount = [prefs integerForKey:@"ReminderCount"];
    NSLog(@"reminderCount=%d",reminderCount);
}
 
//-----------------------------------------


#pragma mark - Add Remove ViewControllers
//-----------------------------------------
- (void) Fn_AddMenu
{
    
}
- (void) Fn_SubMenu
{
    
}

- (void) Fn_AddBrowseQuestion
{
    
}
- (void) Fn_SubBrowseQuestion
{
    
}

- (void) Fn_AddCreateQuiz
{
    
}
- (void) Fn_SubCreateQuiz
{
    
}

- (void) Fn_AddScore
{
    
}
- (void) Fn_SubScore
{
    
}


//Info
- (void) Fn_ShowInfoViewPopup
{
     if([UIScreen mainScreen].bounds.size.height == 568.0)
     {
         infoViewController=[[InfoViewController alloc] initWithNibName:@"InfoViewController_iPhone5" bundle:nil];
     }
     else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
     {
         infoViewController=[[InfoViewController alloc] initWithNibName:@"InfoViewController_iPhone" bundle:nil];
     
     }else
     {
        infoViewController=[[InfoViewController alloc] initWithNibName:@"InfoViewController_iPad" bundle:nil];
     } 
    
        //[self.window.rootViewController.view addSubview:infoViewController.view];
        
        [self.navigationController.visibleViewController.view addSubview:infoViewController.view];

        self.navigationController.visibleViewController.navigationController.navigationBar.alpha = 0.5;
        
        self.navigationController.visibleViewController.navigationController.navigationBar.userInteractionEnabled = NO;
        
        [infoViewController shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
     
    
}
- (void) Fn_SubInfoViewPopup
{
    self.navigationController.visibleViewController.navigationController.navigationBar.userInteractionEnabled = YES;
    self.navigationController.visibleViewController.navigationController.navigationBar.alpha = 1.0;
    
    [infoViewController.view removeFromSuperview];
}

//Help
- (void) Fn_ShowHelpViewPopup
{
    
    if([UIScreen mainScreen].bounds.size.height == 568.0)
    {
        helpViewController=[[HelpViewController alloc] initWithNibName:@"HelpViewController_iPhone5" bundle:nil];
        
    } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        helpViewController=[[HelpViewController alloc] initWithNibName:@"HelpViewController_iPhone" bundle:nil];
        
    }else
    {
    
       helpViewController=[[HelpViewController alloc] initWithNibName:@"HelpViewController_iPad" bundle:nil];
    }
    //    [InfoPopupView shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
    
    //[self.window.rootViewController.view addSubview:helpViewController.view];
    
    [self.navigationController.visibleViewController.view addSubview:helpViewController.view];
    
    self.navigationController.visibleViewController.navigationController.navigationBar.userInteractionEnabled = NO;
    
    self.navigationController.visibleViewController.navigationController.navigationBar.alpha = 0.5;
    
    [helpViewController shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
    
}
- (void) Fn_SubHelpViewPopup
{
    self.navigationController.visibleViewController.navigationController.navigationBar.userInteractionEnabled = YES;
    self.navigationController.visibleViewController.navigationController.navigationBar.alpha = 1.0;
    
    [helpViewController.view removeFromSuperview];    
}

//Note
-(void) Fn_AddNote:(Notes *)notes
{
    notesViewController=[[NotesViewController alloc] initWithNibName:@"NotesViewController_iPad" bundle:nil];
    [notesViewController fnSetData:notes];
    
    //[self.window.rootViewController.view addSubview:notesViewController.view];
    
    [self.navigationController.visibleViewController.view addSubview:notesViewController.view];
    
    self.navigationController.visibleViewController.navigationController.navigationBar.userInteractionEnabled = NO;
    
    self.navigationController.visibleViewController.navigationController.navigationBar.alpha = 0.5;
    
}
-(void) Fn_SetNoteIcons:(BOOL)flag
{
    id obj = self.navigationController.visibleViewController;
    [obj fnSetNoteIcon:flag];
}
-(void) Fn_SubNote
{
    self.navigationController.visibleViewController.navigationController.navigationBar.userInteractionEnabled = YES;
    
    self.navigationController.visibleViewController.navigationController.navigationBar.alpha = 1.0;
    
    [notesViewController.view removeFromSuperview];
    
}
//-----------------------------------------

//----------------------------------------
-(void) Fn_CallPopupOrientaion {
    [helpViewController shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
    [infoViewController shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
    [notesViewController shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
    
  
    [VImageViewController shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
}


//
-(void) Fn_ZoomImgWithView:(NSString *)view
{
//   [self.window addSubview:view];
//    
//    VImageViewController
    VImageViewController=[[ViewImageViewController alloc] initWithNibName:@"ViewImageViewController" bundle:nil];
    [VImageViewController fnSetData:view];
    [self.window.rootViewController.view addSubview:VImageViewController.view];
     [VImageViewController shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
}

- (void) Fn_SubZoomImagePopup
{
    [VImageViewController.view removeFromSuperview];
    
}
//----------------------------------------



#pragma mark - LinkedIn
//-----------------------------------------



//-----------------------------------------

#pragma mark - Delegates
//-----------------------------------------


//-----------------------------------------

@end

#pragma mark - Navigation Controller Rotation
//-----------------------------------------

@implementation UINavigationController (Custom)

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    }
    DEVICE_ORIENTATION = interfaceOrientation;
    [md Fn_CallPopupOrientaion];
    return [self.visibleViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

-(NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    }
    
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    DEVICE_ORIENTATION = interfaceOrientation;
    [md Fn_CallPopupOrientaion];
    return [self.visibleViewController supportedInterfaceOrientations];
}

-(BOOL)shouldAutorotate
{
    return YES;
}


//-----------------------------------------

@end
