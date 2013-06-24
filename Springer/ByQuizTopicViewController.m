//
//  QuizResultViewController.m
//  Springer1.1
//
//  Created by PUN-MAC-012 on 08/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "ByQuizTopicViewController.h"
#import "ScoreQuizTopicViewController.h"
#import "CustomLeftBarItem.h"
#import "CustomRightBarItem.h"
#import "Chapters.h"
#import "QuizScore.h"
#import "Questions.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTitle.h"


@interface ByQuizTopicViewController ()
{
    CustomLeftBarItem *customLeftBar;
    CustomRightBarItem *customRightBar;
    CustomTitle *Title;
      UIColor *row_color_selected_l;
     UIColor *row_color_selected_P;
     UIColor *row_color_selected;
}
@end

@implementation ByQuizTopicViewController

@synthesize Tbl_view;
@synthesize View_Tbl;
@synthesize Img_bg;
@synthesize int_modebyTopicQuiz;


//-----------------------------------------------
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
    float currentVersion = 6.0;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= currentVersion)
    {
        [self supportedInterfaceOrientations];
    }
    else{
        [self shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
    }
    
    [Tbl_view reloadData];
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self fnSetFontColor];
    [self fnSetNavigationItems];
    [self fnSetCornerRadius];
    
    if (int_modebyTopicQuiz == 1) {
        [db fnGetQuizScoreData];
    }
    Tbl_view.bounces=NO;
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-----------------------------------------------

#pragma mark - Normal Functions
//-----------------------------------------
-(void)fnSetFontColor
{
    self.view.backgroundColor = COLOR_BG_BLUE;
    View_Tbl.backgroundColor = COLOR_BG_BLACK;
     row_color_selected_l = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Img_Bn_ScoreByTopicBg.png"]];
    row_color_selected_P = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Img_Bn_ScoreByTopicBg_P"]];
     row_color_selected = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Img_Bn_ScoreByTopicBg_a"]];
//    self.navigationController.navigationBar.backgroundColor = COLOR_BG_BLUE;
    
}
-(void)fnSetCornerRadius
{
    CALayer *layer = [View_Tbl layer];
    [layer setCornerRadius:10.0];
    
    CALayer *layer_tblTpoics = [Tbl_view layer];
    [layer_tblTpoics setCornerRadius:7.0];
    
}
-(void)fnSetNavigationItems
{
    customLeftBar = [[CustomLeftBarItem alloc] initWithFrame:CGRectMake(5, 6, 73, 34)];
    customLeftBar.btnBack.frame=CGRectMake(0, 0,73,34);
    [customLeftBar.btnBack setTitle:@"  Scores" forState:UIControlStateNormal];
    [customLeftBar.btnBack setTitle:@"  Scores" forState:UIControlStateHighlighted];
    UIBarButtonItem *btnBar1 = [[UIBarButtonItem alloc] initWithCustomView:customLeftBar];
    self.navigationItem.leftBarButtonItem = btnBar1;
    [customLeftBar.btnBack addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    customLeftBar.btnBack.hidden = NO;
    
    
    customRightBar = [[CustomRightBarItem alloc] initWithFrame:CGRectMake(0, 0, 34, 44)];
    customRightBar.btnhelp.frame=CGRectMake(0, 6, 34, 34);
    UIBarButtonItem *btnBar2 = [[UIBarButtonItem alloc] initWithCustomView:customRightBar];
    self.navigationItem.rightBarButtonItem = btnBar2;
    customRightBar.btnInfo.hidden = YES;
    
    Title=[[CustomTitle alloc]initWithFrame:CGRectMake(100, 0, 400, 44)];
    
    if (int_modebyTopicQuiz == 1) {
        Title.LblTitle.text=@"Scores by Quiz";
    }
    else {
        Title.LblTitle.text=@"Scores by Topic";
    }
    self.navigationItem.titleView=Title;
    
}
//-----------------------------------------------


//-----------------------------------------------
#pragma mark - Button Actions
//-----------------------------------------
-(IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-----------------------------------------------


#pragma mark - TableView
//-----------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int tbl_row;
     UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation==1||interfaceOrientation==2) {
        tbl_row=18;
    }
    else
    {
        tbl_row=9;

    }
    if (int_modebyTopicQuiz == 1)
    {
        if ([quizscoreDbData count]>tbl_row) {
             return [quizscoreDbData count];
        }
        else
        {
            return tbl_row;
            
        }
       
    }
    else
    {
        if ([chapterDbData count]>tbl_row)
        {
         return [chapterDbData count];
        }
        else
        {
            return tbl_row;
            
        }
    }


    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (int_modebyTopicQuiz == 1) {
        if (indexPath.row < [quizscoreDbData count])
        {
            QuizScore *objScore = (QuizScore *)[quizscoreDbData objectAtIndex:indexPath.row];
            cell.textLabel.text =[NSString stringWithFormat:@" %@",objScore.strQuizName];
            cell.textLabel.textColor = COLOR_BG_BLUE;
            cell.textLabel.highlightedTextColor = COLOR_BG_BLUE;
            cell.textLabel.font = FONT_Trebuchet_MS_15;
            
            if (interfaceOrientation==1||interfaceOrientation==2) {
                cell.contentView.backgroundColor = row_color_selected_P;
            }
            else{
                cell.contentView.backgroundColor = row_color_selected_l;
            }
            cell.textLabel.backgroundColor=COLOR_CLEAR;
        }
        else {
            if (interfaceOrientation==1||interfaceOrientation==2) {
                cell.contentView.backgroundColor = row_color_selected;
            }
            else{
                cell.contentView.backgroundColor =row_color_selected;
            }
            cell.userInteractionEnabled = NO;
        }

    }
    else if (int_modebyTopicQuiz == 2)
    {
        if (indexPath.row < [chapterDbData count])
        {
            Chapters *objChap = (Chapters *)[chapterDbData objectAtIndex:indexPath.row];
            cell.textLabel.text =[NSString stringWithFormat:@" %@",objChap.strChapterTitle];
            
            cell.textLabel.textColor = COLOR_BG_BLUE;
            cell.textLabel.highlightedTextColor = COLOR_BG_BLUE;
            cell.textLabel.font = FONT_Trebuchet_MS_15;
            
            if (interfaceOrientation==1||interfaceOrientation==2) {
                cell.contentView.backgroundColor = row_color_selected_P;
            }
            else{
                cell.contentView.backgroundColor = row_color_selected_l;
            }
            cell.textLabel.backgroundColor=COLOR_CLEAR;
        }
        else {
            if (interfaceOrientation==1||interfaceOrientation==2) {
                cell.contentView.backgroundColor = row_color_selected;
            }
            else{
                cell.contentView.backgroundColor =row_color_selected;
            }
            cell.userInteractionEnabled = NO;
        }
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row < [quizscoreDbData count]|| indexPath.row < [chapterDbData count])
    {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
       
        if (interfaceOrientation==1||interfaceOrientation==2) {
            cell.contentView.backgroundColor = COLOR_TEMPLATE_ROW;
        }
        else{
            cell.contentView.backgroundColor = COLOR_TEMPLATE_ROW;
        }
        
        ScoreQuizTopicViewController *result= [[ScoreQuizTopicViewController alloc]initWithNibName:@"ScoreQuizTopicViewController" bundle:nil];
        
        if (int_modebyTopicQuiz == 1) {
            QuizScore *objQuizScore = [quizscoreDbData objectAtIndex:indexPath.row];
            
            str_Bar_Title = objQuizScore.strQuizName;
            
            objQuizScore.intMissedQuestion=0;
            objQuizScore.intcorrectAns=0;
            objQuizScore.intIncorrectAns=0;
            objQuizScore.intTotalScore=0;
            
            [self.navigationController pushViewController:result animated:YES];
            
            for (int i=0; i < [objQuizScore.arrCorrectIncorrectAnswers count]; i++) {
                
                int val = [[objQuizScore.arrCorrectIncorrectAnswers objectAtIndex:i] intValue];
                
                if (val == 0) {
                    objQuizScore.intMissedQuestion++;
                }
                else if (val == 1) {
                    objQuizScore.intcorrectAns++;
                }
                else if (val == 2) {
                    objQuizScore.intIncorrectAns++;
                }
            }
            
            objQuizScore.intTotalScore = ( objQuizScore.intcorrectAns * 100 ) / objQuizScore.arrCorrectIncorrectAnswers.count ;

            result.lblTotalQuestion.text = [NSString stringWithFormat:@"%d", objQuizScore.arrCorrectIncorrectAnswers.count];        
            
            result.lblAnsSubmited.text = [NSString stringWithFormat:@"%d", objQuizScore.intcorrectAns+objQuizScore.intIncorrectAns];
            
            result.lblCorrect.text = [NSString stringWithFormat:@"%d", objQuizScore.intcorrectAns];
            
            result.lblIncorrect.text = [NSString stringWithFormat:@"%d", objQuizScore.intIncorrectAns];
            
            result.lblPerformance.text = [NSString stringWithFormat:@"%d%%", objQuizScore.intTotalScore];

        }
        else {
            
            Chapters *objChap = (Chapters *)[chapterDbData objectAtIndex:indexPath.row];
            
            str_Bar_Title = objChap.strChapterTitle;
            
            NSMutableArray *questions = [db fnGetQuizScoreByChapter:objChap.intChapterId];
            
            int total = [questions count];
            
            QuizScore *objQuizScore = [[QuizScore alloc] init];
            
            objQuizScore.intMissedQuestion=0;
            objQuizScore.intcorrectAns=0;
            objQuizScore.intIncorrectAns=0;
            objQuizScore.intTotalScore=0;

            
            [self.navigationController pushViewController:result animated:YES];
            
            for (int i =0; i< total; i++) {
                Questions *objQuestion = [questions objectAtIndex:i];
                
                int val = objQuestion.intAnswered;
                
                if (val == 0) {
                    objQuizScore.intMissedQuestion++;
                }
                else if (val == 1) {
                    objQuizScore.intcorrectAns++;
                }
                else if (val == 2) {
                    objQuizScore.intIncorrectAns++;
                }
            }
            
            objQuizScore.intTotalScore = ( objQuizScore.intcorrectAns * 100 ) / total ;
            
            result.lblTotalQuestion.text = [NSString stringWithFormat:@"%d", total];
            
            result.lblAnsSubmited.text = [NSString stringWithFormat:@"%d", objQuizScore.intcorrectAns+objQuizScore.intIncorrectAns];
            
            result.lblCorrect.text = [NSString stringWithFormat:@"%d", objQuizScore.intcorrectAns];
            
            result.lblIncorrect.text = [NSString stringWithFormat:@"%d", objQuizScore.intIncorrectAns];
            
            result.lblPerformance.text = [NSString stringWithFormat:@"%d%%", objQuizScore.intTotalScore];
            
        }
    }
    else {
        cell.contentView.backgroundColor = row_color_selected;        
    }
//    [self fnSetQuestionsCount];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      return 41;
}

- (BOOL)tableView:(UITableView *)aTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (int_modebyTopicQuiz == 1)
    {
        if (indexPath.row < [quizscoreDbData count]) {
            return YES;
        }
    }
    return NO;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        QuizScore *objScore = (QuizScore *)[quizscoreDbData objectAtIndex:indexPath.row];
        [db fnDeleteScore:objScore.intScoreId];
        [quizscoreDbData removeObjectAtIndex:indexPath.row];
        [Tbl_view reloadData];
    }
    
}
//-----------------------------------------


#pragma mark - Rotations
//-----------------------------------------
-(void)fn_Portrait
{
    [Img_bg setImage:[UIImage imageNamed:@"Img_View_TextureBg_P"]];
    [Img_bg  setFrame:CGRectMake(0 , 0 ,768,960)];
    [View_Tbl  setFrame:CGRectMake(44.5  , 71 , 675  ,819)];
    [Tbl_view  setFrame:CGRectMake(20  , 20 ,637  ,779)];
    [Tbl_view reloadData];
    [Title setFrame:CGRectMake(184, 0, 400, 44)];
//    [Tbl_view reloadData];
}
-(void)fn_Landscape
{

    
    [Img_bg setImage:[UIImage imageNamed:@"Img_View_TextureBg"]];
    [Img_bg  setFrame:CGRectMake(0 , 0 ,1024,704)];
    [View_Tbl  setFrame:CGRectMake(79  , 45 ,865  ,614)];
    [Tbl_view  setFrame:CGRectMake(20  , 20 ,826  ,574)];
    [Tbl_view reloadData];
    [Title setFrame:CGRectMake(312, 0, 400, 44)];

    

    
}
- (BOOL) shouldAutorotate
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
//-----------------------------------------
@end
