//
//  QuizReviewViewController.m
//  Springer1.1
//
//  Created by PUN-MAC-014 on 25/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "QuizReviewViewController.h"
#import "ReviewTableCell.h"
#import "Questions.h"
#import "QuizScore.h"
#import "BrouseQuestionSetViewController.h"
#import "QuestionSetViewController.h"
#import "CustomLeftBarItem.h"
#import "CustomRightBarItem.h"
#import "CustomButton.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTitle.h"

#import "Notes.h"
#import "Favourites.h"

#import "QuizResultViewController.h"


@interface QuizReviewViewController ()
{
    CustomLeftBarItem *customLeftBar;
    CustomRightBarItem *customRightBar;
    CustomButton *SubmitcustomButton;
    CustomTitle *Title;


    IBOutlet UIImageView *imgTapBar;
    IBOutlet UIView *ViewtblView;

    Notes *objNotes;
    Favourites *objFavourites;
    
    int FromQuizResult;
    
    id parentObject;
    
    UIImage *imgNote;
    UIImage *imgNoteSelected;
    UIImage *imgFavourite;
    UIImage *imgFavouriteSelected;
    UIImage *imgTrue;
    UIImage *imgFalse;
}
@end
NSMutableArray *questiondData;
 QuizScore *objQuizScore;
int quizscoreId;
 NSInteger currentOrientaion;

@implementation QuizReviewViewController
@synthesize view_ReviewTbl;
@synthesize ing_bg;
@synthesize BlackView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    float currentVersion = 6.0;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= currentVersion)
    {
        [self supportedInterfaceOrientations];
    }
    else{
        [self shouldAutorotateToInterfaceOrientation:DEVICE_ORIENTATION];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fnSetNavigationItems];
    [self fnSetFontColor];
    [self fnSetVariables];
    [self fnSetCustomButton];
    [self fnSetCornerRadius];
    
    if (FromQuizResult == 1) {
        Title.LblTitle.text = @"Review Questions";
        [SubmitcustomButton.btn setTitle:@"Done" forState:UIControlStateNormal];
    }
    else {
        Title.LblTitle.text=@"Review Quiz";
        [SubmitcustomButton.btn setTitle:@"Submit" forState:UIControlStateNormal];        
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Normal Functions
//-----------------------------------------
-(void)fnSetNavigationItems
{
    customLeftBar = [[CustomLeftBarItem alloc] initWithFrame:CGRectMake(5, 6, 73, 34)];
    customLeftBar.btnBack.frame=CGRectMake(0, 0,73,34);
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
    Title.LblTitle.text=@"Review Questions";
    self.navigationItem.titleView=Title;
    
}

-(void)fnSetFontColor
{
    self.view.backgroundColor = COLOR_BG_BLUE;
    //    self.navigationController.navigationBar.backgroundColor = COLOR_BG_BLUE;
     BlackView.backgroundColor = COLOR_BG_BLACK;
    
}

-(void)fnSetVariables {
    imgNote = [UIImage imageNamed:@"Img_Bn_Note.png"];
    imgNoteSelected = [UIImage imageNamed:@"Img_Bn_Note_Selected.png"];
    imgFavourite = [UIImage imageNamed:@"Img_Bn_Flag.png"];
    imgFavouriteSelected = [UIImage imageNamed:@"Img_Bn_Flag_Selected.png"];
    imgTrue = [UIImage imageNamed:@"Img_Tick.png"];
    imgFalse = [UIImage imageNamed:@"Img_Cross.png"];
}
-(void)fnSetCornerRadius
{
    CALayer *layer = [BlackView layer];
    [layer setCornerRadius:10.0];
    
    CALayer *layer_tblTpoics = [view_ReviewTbl layer];
    [layer_tblTpoics setCornerRadius:7.0];
    
    CALayer *layer_ViewTpoics = [ViewtblView layer];
    [layer_ViewTpoics setCornerRadius:7.0];
   
}

-(void)fnSetCustomButton
{
    
    SubmitcustomButton = [[CustomButton alloc]initWithFrame:CGRectMake(324,915,176,39)];
    [SubmitcustomButton.btn setTitle:@"Submit" forState:UIControlStateNormal];
    [SubmitcustomButton.btn addTarget:self action:@selector(OnSubmitTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:SubmitcustomButton];
    
}

-(IBAction)OnSubmitTapped:(id)sender
{
    
    if (FromQuizResult == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        QuizResultViewController *result = [[QuizResultViewController alloc] init];
        objQuizScore.intMissedQuestion=0;
        objQuizScore.intcorrectAns=0;
        objQuizScore.intIncorrectAns=0;
        objQuizScore.intTotalScore=0;
            
        [parentObject removeTimer];
        
        [result fnSetData:questiondData AndScore:objQuizScore];
        [self.navigationController pushViewController:result animated:YES];
        
        int totalSubmitedAnswer = 0;
        
        for (int i=0; i < [objQuizScore.arrCorrectIncorrectAnswers count]; i++) {
            
            int val = [[objQuizScore.arrCorrectIncorrectAnswers objectAtIndex:i] intValue];
            
            if (val == 0) {
                objQuizScore.intMissedQuestion++;
            }
            else if (val == 1) {
                totalSubmitedAnswer++;
                objQuizScore.intcorrectAns++;
            }
            else if (val == 2) {
                totalSubmitedAnswer++;
                objQuizScore.intIncorrectAns++;
            }
        }
        
        objQuizScore.intTotalScore = ( objQuizScore.intcorrectAns * 100 ) / totalSubmitedAnswer;
        
        result.lblTotalQuestion.text = [NSString stringWithFormat:@"%d", objQuizScore.arrCorrectIncorrectAnswers.count];
        
        result.lblTitle.text=[NSString stringWithFormat:@"%@", objQuizScore.strQuizName];
        
        result.lblAnsSubmited.text = [NSString stringWithFormat:@"%d", objQuizScore.intcorrectAns+objQuizScore.intIncorrectAns];
        
        result.lblCorrect.text = [NSString stringWithFormat:@"%d", objQuizScore.intcorrectAns];
        
        result.lblIncorrect.text = [NSString stringWithFormat:@"%d", objQuizScore.intIncorrectAns];
        
        result.lblPerformance.text = [NSString stringWithFormat:@"%d%%", objQuizScore.intTotalScore];
        
        [db fnUpdateQuizScoreData:objQuizScore];
    }
}
//--------------------------------------
-(void) fnSetData:(NSArray *)data AndScore:(QuizScore *)score FromQuizResult:(int)flag AndParent:(id)parent
{
    questiondData = [data copy];
    objQuizScore = score;
    FromQuizResult = flag;
    parentObject = parent;
}

-(void)show_Data:(UIButton *)btn
{
    [self fncallShowData:btn.tag];
}

-(void) fncallShowData:(int)tag
{
    if (FromQuizResult == 1) {
        
        BrouseQuestionSetViewController *questionSetViewController = [[BrouseQuestionSetViewController alloc] initWithNibName:@"BrouseQuestionSetViewController" bundle:nil];
        [self.navigationController pushViewController:questionSetViewController animated:YES];
        [questionSetViewController fnSetData:questiondData AndTimer:NO AndCurrentQuestion:tag AndQuizScoreId:quizscoreId AndIsSwipeGesture:NO];
    }
    else {
        FROM_REVIEW_TO_QUIZ = tag;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}


#pragma mark - Button Actions
//-----------------------------------------
-(IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
}
//--------------------------------------

// Table-----------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [objQuizScore.arrCorrectIncorrectAnswers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if(currentOrientaion==1||currentOrientaion==2)
    {    height = 100;
    }
    else
    {
        height = 118;
    }
      return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellID = @"cellID";
    
    ReviewTableCell *cell = (ReviewTableCell *)[tableView dequeueReusableCellWithIdentifier:kCellID];
    if(cell == nil) {
        NSArray *cellArray;
     
        if(currentOrientaion==1||currentOrientaion==2)
        {
            cellArray = [[NSBundle mainBundle] loadNibNamed:@"ReviewTableCell" owner:self options:nil];
        }
        else{
            cellArray = [[NSBundle mainBundle] loadNibNamed:@"ReviewTableCell_p" owner:self options:nil];  
        }
        cell = [cellArray lastObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.Lbl_Questiontlbl.textColor=COLOR_RED;
        cell.Lbl_Questiontlbl.highlightedTextColor=COLOR_RED;
        cell.Lbl_Questiontlbl.font=FONT_Trebuchet_MS_14;
        
        cell.Lbl_Qno.textColor=COLOR_RED;
        cell.Lbl_Qno.highlightedTextColor=COLOR_RED;
        cell.Lbl_Qno.font=FONT_Trebuchet_MS_30;
        
        cell.Lbl_Qstatus.textColor=COLOR_BG_BLUE;
        cell.Lbl_Qstatus.highlightedTextColor=COLOR_BG_BLUE;
        cell.Lbl_Qstatus.font=FONT_Trebuchet_MS_14;
        
        cell.Lbl_Quesion.textColor=COLOR_BLACK_Rgb;
        cell.Lbl_Quesion.highlightedTextColor=COLOR_BLACK_Rgb;
        cell.Lbl_Quesion.font=FONT_Trebuchet_MS_14;
        
//        [cell.webvieQuestion setBackgroundColor:COLOR_CLEAR];
//        [cell.webvieQuestion setOpaque:NO];
         cell.webvieQuestion.scrollView.userInteractionEnabled = NO;
    
        
    }
    
    Questions *objQues = (Questions *)[questiondData objectAtIndex:indexPath.row];
    
    if (indexPath.row+1<=9) {
        cell.Lbl_Qno.text=[NSString stringWithFormat:@"0%d",indexPath.row+1];
    }
    else
    {
        cell.Lbl_Qno.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    }

    int val = [[objQuizScore.arrCorrectIncorrectAnswers objectAtIndex:indexPath.row] intValue];
    
    if (val == 0)
    {
        cell.Lbl_Qstatus.text=@"SKIPPED";
    }
    else{
        cell.Lbl_Qstatus.text=@"ANSWERED";
    }
    NSMutableString *str=objQues.strQuestionText;
    NSString *cleanStringb = [str stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
     NSString *cleanStringbe=[cleanStringb stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
     NSString *cleanStringi = [cleanStringbe stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
     NSString *cleanStringie = [cleanStringi stringByReplacingOccurrencesOfString:@"</i>" withString:@""];
     NSString *cleanStringbr = [cleanStringie stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    
    cell.Lbl_Quesion.text=cleanStringbr;
//    [cell.webvieQuestion loadHTMLString:[NSString stringWithFormat: @"<html><body style=\"font-size:14px;font-family:Trebuchet MS;font-color:#333333;backround-color:red;\">%@</body></html>",objQues.strQuestionText] baseURL:nil];
    cell.Btn_Show.tag = indexPath.row;
    [cell.Btn_Show addTarget:self action:@selector(show_Data:) forControlEvents:UIControlEventTouchUpInside];
    
    // Answer
    if (FromQuizResult == 0) {
        cell.Img_Answer.hidden = YES;
    }
    else {
        cell.Img_Answer.hidden = NO;
        if (val == 0)
        {
            cell.Img_Answer.hidden = YES;
        }
        else if (val == 1)
        {
            [cell.Img_Answer setImage:imgTrue];
            [cell.Img_Answer setFrame:CGRectMake(cell.Img_Answer.frame.origin.x, cell.Img_Answer.frame.origin.y, 30, 23)];
        }
        else if (val == 2)

        {
            [cell.Img_Answer setImage:imgFalse];
            [cell.Img_Answer setFrame:CGRectMake(cell.Img_Answer.frame.origin.x, cell.Img_Answer.frame.origin.y, 23, 23)];
        }

    }
    
    // Check Note
     objNotes = [db fnGetNote:objQues.intQuestionId AndChapterID:objQues.intChapterId AndQuizScoreId:objQuizScore.intScoreId];
    

    if (objNotes != nil) {
        [cell.Btn_Img2  setImage:imgNoteSelected forState:UIControlStateNormal];
        [cell.Btn_Img2  setImage:imgNoteSelected forState:UIControlStateHighlighted];
    }
        
    
    objFavourites = [db fnCheckFavourites: objQues.intQuestionId AndChapterID:objQues.intChapterId AndQuizScoreId:objQuizScore.intScoreId];
    if (objFavourites != nil) {
        [cell.Btn_Img1 setImage:imgFavouriteSelected forState:UIControlStateNormal];
        [cell.Btn_Img1 setImage:imgFavouriteSelected forState:UIControlStateHighlighted];
    }

    
    if (currentOrientaion == 1 || currentOrientaion == 2) {
        cell.Lbl_Quesion.numberOfLines = 2;
    }
    else {
        cell.Lbl_Quesion.numberOfLines = 3;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewTableCell *cell = (ReviewTableCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.selection_view.backgroundColor = COLOR_TEMPLATE_ROW;
    [self fncallShowData:indexPath.row];
}
// -----------------------------------


#pragma mark - Rotations
//-----------------------------------------
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
//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    
//    
//    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait ) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown ))
//    {
//        [self fn_Portrait];
//        
//    }
//    
//    else if(( [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft )||([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight ))
//        
//    {
//        [self fn_Landscape];
//        
//    }
//    
//}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        return NO;
    }
    currentOrientaion = interfaceOrientation;
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
    //self.view.frame = CGRectMake(0, 0, 768, 1024);
    
    currentOrientaion=3;
    [ing_bg setFrame:CGRectMake(0, 0, 768, 960 )];
    [ing_bg setImage:[UIImage imageNamed:@"Img_View_TextureBg_P"]];
    [BlackView setFrame:CGRectMake(36, 76, 696, 762)];
    [ViewtblView setFrame:CGRectMake(65, 106, 640, 705)];
    [view_ReviewTbl  setFrame:CGRectMake(0, 0, 640, 705)];
    [view_ReviewTbl reloadData];
   
    [imgTapBar setFrame:CGRectMake(0,915,768,48)];
    [imgTapBar setImage: [UIImage imageNamed:@"Img_Tabbar_P"]];
    [SubmitcustomButton setFrame:CGRectMake(299,918,176,39)];
    [Title setFrame:CGRectMake(184, 0, 400, 44)];
    
    
}
-(void)fn_Landscape
{
    //self.view.frame = CGRectMake(0, 0, 1024, 768);
    
    currentOrientaion=1;
    [ing_bg setFrame:CGRectMake(0, 0, 1024, 704)];
    [ing_bg setImage:[UIImage imageNamed:@"Img_View_TextureBg"]];
    [BlackView setFrame:CGRectMake(71, 50, 882, 552)];
    [ViewtblView setFrame:CGRectMake(100, 78, 826, 500)];
    [view_ReviewTbl  setFrame:CGRectMake(0, 0, 826, 500)];
    [view_ReviewTbl reloadData];

    [imgTapBar setFrame:CGRectMake(0,656,1024,48)];
    [imgTapBar setImage: [UIImage imageNamed:@"Img_Tabbar"]];
    [SubmitcustomButton setFrame:CGRectMake(424,661 ,176,39)];
   [Title setFrame:CGRectMake(312, 0, 400, 44)];
    
    
    
    
}
//-----------------------------------------
@end
