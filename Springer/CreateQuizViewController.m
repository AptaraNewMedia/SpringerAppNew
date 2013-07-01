//
//  CreateQuizViewController.m
//  Springer
//
//  Created by PUN-MAC-012 on 02/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "CreateQuizViewController.h"
#import "Chapters.h"
#import "Questions.h"
#import "QuizScore.h"
#import "QuestionSetViewController.h"
#import "CustomLeftBarItem.h"
#import "CustomRightBarItem.h"
#import "CustomButton.h"
#import "CustomTitle.h"
#import "QuizReviewViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CreateQuizViewController ()
{
    IBOutlet UIImageView *imgViewBg;
    
    IBOutlet UILabel *lblEnterQuizName;
    IBOutlet UILabel *lblQuestionFilter;
    IBOutlet UILabel *lblSelectedTopics;
    IBOutlet UILabel *lblSelectedQuestions;
    IBOutlet UILabel *lblSelectedQuestionsCount;
     IBOutlet UILabel *lblTimer;
    
    IBOutlet UITextField *txtQuizNameInput;
    
    IBOutlet UITableView *tblQuestionFilter;
    IBOutlet UITableView *tblTopics;
    IBOutlet UIView *ViewQuestionFilter;
    IBOutlet UIView *ViewTopics;
    
    IBOutlet UISlider *sliderQuestions;
    
    IBOutlet UIButton *btnBeginQuiz;
    IBOutlet UIButton *btnClearSelection;
    
    IBOutlet UIView *viewBgPatch;
    
    IBOutlet UISwitch *switchTimer;
    
    IBOutlet UIScrollView *scrollView;
    
    NSArray *arrFilter;
    NSArray *arrFilterType;
    NSArray *arrFilterQuestions;
    NSMutableArray *arrChapter;
    NSMutableArray *arrPredicate;
    int intTotalQuestions;
    int sliderValue;
    
    CustomLeftBarItem *customLeftBar;
    CustomRightBarItem *customRightBar;
    CustomButton *customButton_BnClear;
    CustomButton *customButton_BnBegin;
    CustomTitle *Title;
    
    NSInteger currentOrientaion;
    
    UIColor *row_color_l;
    UIColor *row_color_selected_l;
    
    UIColor *row_color_p;
    UIColor *row_color_selected_p;
    
    NSMutableArray *arrCounterLabel;
    
    NSMutableArray *arrSelectedCells;
    NSMutableArray *arrSelectedCellsFilter;    
}

-(void)fnSetFontColor;
-(void)fnSetNavigationItems;
-(void)fnSetVariables;
-(void)fnRotatePortrait;
-(void)fnRotateLandscape;

-(void)fnSetQuestionsCount;
-(void)fnSetFilteredQuestionsCount;
-(void)fnSetCornerRadius;
-(void)fnSetCustomButton;

-(IBAction)onQuizTapped:(id)sender;
-(IBAction)onClearSelectionTapped:(id)sender;
-(IBAction)sliderValueChangedAction:(id)sender;
-(IBAction)switchValueChnageAction:(id)sender;
@end

@implementation CreateQuizViewController

#pragma mark - Defaults
//-----------------------------------------
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
    [self fnSetCurrentDateTime];
    [self onClearSelectionTapped:nil];
   
    
    float currentVersion = 6.0;
    
    if (DEVICE_VERSION >= currentVersion)
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
    // Do any additional setup after loading the view from its nib.
//    self.title= @"Create Quiz";
    self.navigationController.navigationBarHidden = NO;
    [self fnSetFontColor];
    [self fnSetNavigationItems];
    [self fnSetCurrentDateTime];
    [self fnSetVariables];
    [self fnAddItemsToScrollview];
    [self fnSetCornerRadius];
    [self fnSetCustomButton];
}

-(void)viewDidUnload
{
    imgViewBg = nil;
    
    lblEnterQuizName = nil;
    lblQuestionFilter = nil;
    lblSelectedTopics = nil;
    lblSelectedQuestions = nil;
    lblSelectedQuestionsCount = nil;
    
    txtQuizNameInput = nil;
    
    tblQuestionFilter = nil;
    tblTopics = nil;
    
    sliderQuestions = nil;
    
    btnBeginQuiz = nil;
    btnClearSelection = nil;
    
    viewBgPatch = nil;
    
    arrFilter = nil;
    arrFilterType = nil;
    arrFilterQuestions = nil;
    arrChapter = nil;
    arrPredicate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-----------------------------------------

#pragma mark - Normal Functions
//-----------------------------------------
-(void)fnSetFontColor
{
    self.view.backgroundColor = COLOR_BG_BLUE;
    self.navigationController.navigationBar.backgroundColor = COLOR_BG_BLUE;
    viewBgPatch.backgroundColor = COLOR_BG_BLACK;
    
    lblEnterQuizName.textColor = COLOR_TEXT_WHITE;
    lblQuestionFilter.textColor = COLOR_TEXT_WHITE;
    lblSelectedTopics.textColor = COLOR_TEXT_WHITE;
    lblSelectedQuestions.textColor = COLOR_TEXT_WHITE;
    lblSelectedQuestionsCount.textColor = COLOR_TEXT_WHITE;
    
    txtQuizNameInput.textColor = COLOR_TEXT_WHITE_Rgb;
    lblEnterQuizName.font = FONT_Helvetica_Roman_20;
    lblQuestionFilter.font = FONT_Helvetica_Roman_20;
    lblSelectedTopics.font = FONT_Helvetica_Roman_20;
    lblSelectedQuestions.font = FONT_Helvetica_Roman_20;
    lblSelectedQuestionsCount.font = FONT_Helvetica_Roman_20;
    txtQuizNameInput.font = FONT_Helvetica_17;
    
    if (DEVICE_VERSION > CURRENT_VERSION)
    {
    sliderQuestions.minimumTrackTintColor = COLOR_RED;
    }
    //
    lblEnterQuizName.shadowColor = COLOR_BG_BLACK_30;
    lblEnterQuizName.shadowOffset = CGSizeMake(0, 3.0);
    lblQuestionFilter.shadowColor = COLOR_BG_BLACK_30;
    lblQuestionFilter.shadowOffset = CGSizeMake(0, 3.0);
    lblSelectedTopics.shadowColor = COLOR_BG_BLACK_30;
    lblSelectedTopics.shadowOffset = CGSizeMake(0, 3.0);
    lblSelectedQuestions.shadowColor = COLOR_BG_BLACK_30;
    lblSelectedQuestions.shadowOffset = CGSizeMake(0, 3.0);
    lblSelectedQuestionsCount.shadowColor = COLOR_BG_BLACK_30;
    lblSelectedQuestionsCount.shadowOffset = CGSizeMake(0, 3.0);
    lblTimer.textColor=COLOR_TEXT_WHITE;
    lblTimer.font=FONT_Helvetica_Roman_20;
    lblTimer.shadowColor = COLOR_BG_BLACK_30;
    lblTimer.shadowOffset = CGSizeMake(0, 3.0);
    
}

-(void)fnSetNavigationItems
{
    customLeftBar = [[CustomLeftBarItem alloc] initWithFrame:CGRectMake(5, 6, 73, 34)];
    customLeftBar.btnBack.frame=CGRectMake(0, 0,73,34);
    [customLeftBar.btnBack setTitle:@"  Home" forState:UIControlStateNormal];
    [customLeftBar.btnBack setTitle:@"  Home" forState:UIControlStateHighlighted];
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
    Title.LblTitle.text=@"Create Quiz";
     self.navigationItem.titleView=Title;
    
    
}

-(void)fnSetVariables
{
    arrFilter = [[NSArray alloc] initWithObjects:@"Select All",@"Unused Questions",@"Used Questions",@"Incorrectly Answered Questions",@"Flagged Questions", nil];
    arrFilterType = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    lblSelectedQuestionsCount.text = @"0/0";
    
    switchTimer.on = NO;
    
    [sliderQuestions setMaximumValue:0];
    [sliderQuestions setValue:0];

    
    row_color_p = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Img_Bn_TopicName_P"]];
    row_color_selected_p = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Img_Bn_TopicName_Selected_P.png"]];
    row_color_l = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Img_Bn_TopicName"]];
    row_color_selected_l = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Img_Bn_TopicName_Selected.png"]];
    
    arrCounterLabel = [[NSMutableArray alloc] init];
    
    txtQuizNameInput.text = CURRENT_DATE_TIME;
}

-(void)fnSetQuestionsCount
{
    NSArray *selectedTopics = [tblTopics indexPathsForSelectedRows];
    arrChapter = [[NSMutableArray alloc] init];
    arrSelectedCells = [[NSMutableArray alloc] init];
    for (int i = 0; i < [selectedTopics count]; i++) {
        NSIndexPath *indexpath = [selectedTopics objectAtIndex:i];
        [arrSelectedCells addObject:indexpath];
        if (indexpath.row == 0) {
            for (int k=0; k<chapterDbData.count; k++) {
                Chapters *objChap = [chapterDbData objectAtIndex:k];
                [arrChapter addObject:[ NSNumber numberWithInt:objChap.intChapterId]];
            }
            
        }
        else {
            Chapters *objChap = [chapterDbData objectAtIndex:indexpath.row-1];
            [arrChapter addObject:[ NSNumber numberWithInt:objChap.intChapterId]];
        }
    }
    
    int used = -1;
    int unused = -1;
    int bookmark = 0;
    int answered = -1;
    
    NSArray *selectedFilter = [tblQuestionFilter indexPathsForSelectedRows];
    
    arrSelectedCellsFilter = [[NSMutableArray alloc] init];
    for (NSIndexPath *indexpath in selectedFilter) {
        [arrSelectedCellsFilter addObject:indexpath];
    }
    
    for (int i = 0; i < [selectedFilter count]; i++) {
        NSIndexPath *indexpath = [selectedFilter objectAtIndex:i];
        
        if (indexpath.row == 0) {
            used = -1;
            unused = -1;
            bookmark = 0;
            answered = -1;
            break;
        }
        else {
            switch (indexpath.row) {
                case UNUSED_QUESTIONS:
                    unused = 0;
                    break;
                case USED_QUESTIONS:
                    used = 1;
                    break;
                case INCORRECT_ANSWERED:
                    answered = 2;
                    break;
                case BOOKMARKED_QUESTIONS:
                    bookmark = 1;
                    break;
            }
        }
        
        
    }
    
    if ([selectedFilter count] > 0) {
        [db fnGetQuestionList:arrChapter withUsed:used withunUsed:unused withBookmark:bookmark withAnswered:answered withNotes:0];
        arrFilterQuestions = [questionsDbData copy];
        intTotalQuestions = [arrFilterQuestions count];
        lblSelectedQuestionsCount.text = [NSString stringWithFormat:@"%d/%d", intTotalQuestions, intTotalQuestions];
        [sliderQuestions setMaximumValue:(float)intTotalQuestions];
        [sliderQuestions setValue:(float)intTotalQuestions];
    }
    else {
        intTotalQuestions = 0;
        lblSelectedQuestionsCount.text = [NSString stringWithFormat:@"%d/%d", intTotalQuestions, intTotalQuestions];
        [sliderQuestions setMaximumValue:(float)intTotalQuestions];
        [sliderQuestions setValue:(float)intTotalQuestions];        
    }
    
    
    [self fnSetFilteredQuestionsCount];    
    
}

-(void)fnSetFilteredQuestionsCount
{
    int used = 0;
    int bookmark = 0;
    int answered = 0;
    int unused = 0;
    int total = 0;
    
    NSMutableArray *tempdata = [db fnGetQuestionListByChapter:arrChapter];
    
    for (Questions *objQuestion in  tempdata) {
        if (objQuestion.intUsed == 0) {
            unused++;
        }
        else  if (objQuestion.intUsed == 1) {
            used++;
        }
        
        if (objQuestion.intBookmark == 1) {
            bookmark++;
        }
        
        if (objQuestion.intAnswered == 2 || objQuestion.intAnswered == 0) {
            answered++;
        }
    }
    
    total = [tempdata count];
    
    //if (tempdata.count > 0) {
    arrFilterType = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:unused], [NSNumber numberWithInt:used], [NSNumber numberWithInt:answered], [NSNumber numberWithInt:bookmark], [NSNumber numberWithInt:total], nil];
    
    //[tblQuestionFilter reloadData];
    
    int x =0;
    for (UILabel *lbl in arrCounterLabel) {
        switch (x) {
            case 1:
                lbl.text = [NSString stringWithFormat:@"%d", unused];
                
                if (unused == 0) {
                    lbl.text = @"";
                    lbl.backgroundColor = COLOR_CLEAR;
                }
                else {
                    lbl.backgroundColor = COLOR_BLUE_FILTER;
                }
                break;
            case 2:
                lbl.text = [NSString stringWithFormat:@"%d", used];
                if (used == 0) {
                    lbl.text = @"";
                    lbl.backgroundColor = COLOR_CLEAR;
                }
                else {
                    lbl.backgroundColor = COLOR_BLUE_FILTER;
                }
                break;
                
            case 3:
                lbl.text = [NSString stringWithFormat:@"%d", answered];
                if (answered == 0) {
                    lbl.text = @"";
                    lbl.backgroundColor = COLOR_CLEAR;
                }
                else {
                    lbl.backgroundColor = COLOR_BLUE_FILTER;
                }
                break;
                
            case 4:
                lbl.text = [NSString stringWithFormat:@"%d", bookmark];
                if (bookmark == 0) {
                    lbl.text = @"";
                    lbl.backgroundColor = COLOR_CLEAR;
                }
                else {
                    lbl.backgroundColor = COLOR_BLUE_FILTER;
                }
                break;
                
            case 0:
                lbl.text = [NSString stringWithFormat:@"%d", total];
                if (total == 0) {
                    lbl.text = @"";
                    lbl.backgroundColor = COLOR_CLEAR;
                }
                else {
                    lbl.backgroundColor = COLOR_BLUE_FILTER;
                }
                break;
                
        }
        
        
        x++;
    }
    
    //}
}

-(void)fnSetCornerRadius
{
    CALayer *layer = [viewBgPatch layer];
    [layer setCornerRadius:10.0];
    
    CALayer *layer_tblTpoics = [tblTopics layer];
    [layer_tblTpoics setCornerRadius:7.0];
    
    CALayer *layer_tblQuestion = [tblQuestionFilter layer];
    [layer_tblQuestion setCornerRadius:7.0];
    
    CALayer *layer_ViewTpoics = [ViewTopics layer];
    [layer_ViewTpoics setCornerRadius:7.0];
    
    CALayer *layer_ViewQuestion = [ViewQuestionFilter layer];
    [layer_ViewQuestion setCornerRadius:7.0];
    
    CALayer *layer_scroll = [scrollView layer];
    [layer_scroll setCornerRadius:7.0];
    
//    tblQuestionFilter.layer.shadowRadius = 1.5;
//    tblQuestionFilter.layer.shadowOpacity = 0.3;
//    tblQuestionFilter.layer.shadowOffset=CGSizeMake(0, 3.0);
  
    
//    scrollView.layer.shadowRadius = 1.5;
//    scrollView.layer.shadowOpacity = 0.3;
//    scrollView.layer.shadowOffset=CGSizeMake(0, 3.0);
//    scrollView.bounces=NO;


}

-(void)fnSetCustomButton
{
    //
    customButton_BnClear = [[CustomButton alloc]initWithFrame:CGRectMake(480, 560, 176, 39)];
    [customButton_BnClear.btn setTitle:@"Clear Selection" forState:UIControlStateNormal];
    [customButton_BnClear.btn addTarget:self action:@selector(onClearSelectionTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton_BnClear];
    
    //
    customButton_BnBegin = [[CustomButton alloc]initWithFrame:CGRectMake(662, 560, 176, 39)];
    [customButton_BnBegin.btn setTitle:@"Begin" forState:UIControlStateNormal];
    [customButton_BnBegin.btn addTarget:self action:@selector(onQuizTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton_BnBegin];
    

}

-(void)fnSetCurrentDateTime
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *currentDate = [NSDate date];
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy HH:mm"];
    CURRENT_DATE_TIME = [dateFormat stringFromDate:currentDate];
}

-(void)fnAddItemsToScrollview
{
    tblQuestionFilter.scrollEnabled = NO;
    tblTopics.scrollEnabled = NO;
    
    scrollView = [[UIScrollView alloc] init];
    [scrollView.layer setCornerRadius:10];
    [self.view addSubview:scrollView];

    [scrollView addSubview:lblQuestionFilter];
    [scrollView addSubview:tblQuestionFilter];
    [scrollView addSubview:lblSelectedTopics];
    [scrollView addSubview:tblTopics];
}

-(void)fnChangeTickmarkSizes
{
    for (UILabel *lbl in arrCounterLabel) {
        [lbl setFrame:CGRectMake(tblQuestionFilter.frame.size.width - 90, lbl.frame.origin.y, lbl.frame.size.width, lbl.frame.size.height)];
        
    }
    
    for(NSIndexPath *indexPath in arrSelectedCellsFilter)
    {
        UITableViewCell *cell = [tblQuestionFilter cellForRowAtIndexPath:indexPath];
        if (currentOrientaion == 1 || currentOrientaion == 2)
            cell.contentView.backgroundColor = row_color_selected_p;
        else
            cell.contentView.backgroundColor = row_color_selected_l;
        [tblQuestionFilter selectRowAtIndexPath:indexPath animated:NO scrollPosition:NO];
    }
    
    for(NSIndexPath *indexPath in arrSelectedCells)
    {
        UITableViewCell *cell = [tblTopics cellForRowAtIndexPath:indexPath];
        if (currentOrientaion == 1 || currentOrientaion == 2)
            cell.contentView.backgroundColor = row_color_selected_p;
        else
            cell.contentView.backgroundColor = row_color_selected_l;
        [tblTopics selectRowAtIndexPath:indexPath animated:NO scrollPosition:NO];
    }
}
//-----------------------------------------


#pragma mark - Button Actions
//-----------------------------------------
-(IBAction)onBack:(id)sender
{
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onQuizTapped:(id)sender
{
    
    UIAlertView *alertView = [[UIAlertView alloc] init];

    if(!txtQuizNameInput.text.length > 0) {
        // Alert
        alertView.title = TITLE_MSG;
        alertView.message = MSG_QUIZ_NAME;
        [alertView addButtonWithTitle:BTN_OK];
        [alertView show];
        return;
    }


    if ([db fnCheckQuizNameExist:txtQuizNameInput.text] == 1) {
        // Alert
        alertView.title = TITLE_MSG;
        alertView.message = MSG_QUIZ_EXIST;
        [alertView addButtonWithTitle:BTN_OK];
        [alertView show];
        return;
    }

    NSArray *selectedFilter = [tblQuestionFilter indexPathsForSelectedRows];
    if (![selectedFilter count] > 0) {
        alertView.title = TITLE_MSG;
        alertView.message = MSG_QUESTION_FILTER;
        [alertView addButtonWithTitle:BTN_OK];
        [alertView show];
        return;
    }


    NSArray *selectedTopics = [tblTopics indexPathsForSelectedRows];
    if (![selectedTopics count] > 0) {
        alertView.title = TITLE_MSG;
        alertView.message = MSG_TOPICS_FILTER;
        [alertView addButtonWithTitle:BTN_OK];
        [alertView show];
        return;
    }
    
    if (arrFilterQuestions.count == 0) {
        alertView.title = TITLE_MSG;
        alertView.message = MSG_NO_DATA;
        [alertView addButtonWithTitle:BTN_OK];
        [alertView show];
        return;
    }
    
    
    int score_id = [db fnGetCountOFQuizScoreId];
    
    score_id = score_id + 1;
    
    QuizScore *objQuizScore = [[QuizScore alloc] init];
    objQuizScore.intScoreId = score_id;
    objQuizScore.strQuizName = txtQuizNameInput.text;
    objQuizScore.intTimer = 0;
    objQuizScore.intRandom = 0;
    
    Questions *objQues = Nil;
    for (int j =0 ; j < [arrFilterQuestions count]; j++) {
        objQues = [arrFilterQuestions objectAtIndex:j];
        [objQuizScore.arrQuizIDs addObject:[NSNumber numberWithInt:objQues.intQuestionId]];
        [objQuizScore.arrQuizVisitedAnswers addObject:@"NA"];
        [objQuizScore.arrCorrectIncorrectAnswers addObject:[NSNumber numberWithInt:0]];
    }
    
    objQuizScore.intTotalScore = 0;
    objQuizScore.arrChapterIds = [arrChapter copy];
    objQuizScore.intCurrentQuestion = 0;
    objQuizScore.intBookmarkQuestion = 0;
    objQuizScore.intIncorrectAns = 0;
    objQuizScore.intMissedQuestion = 0;
    [db fnSetQuizScoreData:objQuizScore];
    
    FROM_REVIEW_TO_QUIZ = 0;
    
    QuestionSetViewController *questionSetViewController = [[QuestionSetViewController alloc] initWithNibName:@"QuestionSetViewController_iPad" bundle:nil];
    [self.navigationController pushViewController:questionSetViewController animated:YES];
    [questionSetViewController fnSetData:arrFilterQuestions AndTimer:switchTimer.on AndCurrentQuestion:0 AndQuizScoreId:score_id];    
}

-(IBAction)onClearSelectionTapped:(id)sender
{
    for (UILabel *lbl in arrCounterLabel) {
        lbl.text = @"";
        lbl.backgroundColor = COLOR_CLEAR;
    }
    
    [arrCounterLabel removeAllObjects];
    
    arrCounterLabel = [[NSMutableArray alloc] init];

    [arrSelectedCells removeAllObjects];    
    arrSelectedCells = [[NSMutableArray alloc] init];
    
    [arrSelectedCellsFilter removeAllObjects];
    arrSelectedCellsFilter = [[NSMutableArray alloc] init];
    
    arrFilterType = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    
    [tblQuestionFilter reloadData];
    
    [tblTopics reloadData];
 
    [self fnSetCurrentDateTime];
    
    txtQuizNameInput.text = CURRENT_DATE_TIME;
    
    lblSelectedQuestionsCount.text = @"0/0";
    
    switchTimer.on = NO;
    
    [sliderQuestions setMaximumValue:0];
    [sliderQuestions setValue:0];
}

-(IBAction)sliderValueChangedAction:(id)sender
{
    sliderValue = round(sliderQuestions.value*1);
    if (sliderValue > 0) {
        lblSelectedQuestionsCount.text = [NSString stringWithFormat:@"%d/%d", sliderValue, intTotalQuestions];
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        if (questionsDbData.count > 0) {
            for (int x = 0; x < sliderValue; x++) {
                
                [temp addObject:[questionsDbData objectAtIndex:random()%intTotalQuestions]];
            }
            arrFilterQuestions = [temp copy];
        }
    }
    
}

-(IBAction)switchValueChnageAction:(id)sender
{

//    switchTimer.On=YES;
    
}
//-----------------------------------------


#pragma mark - TextFiled
//-----------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    txtQuizNameInput.textColor = COLOR_BLACK_Rgb;
}
//-----------------------------------------


#pragma mark - TableView
//-----------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tblQuestionFilter)
        return [arrFilter count];
    else if(tableView == tblTopics)
        return [chapterDbData count]+1;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.contentView.backgroundColor = row_color_l;
        cell.accessoryView.backgroundColor = row_color_l;        
        cell.textLabel.textColor = COLOR_BG_BLUE;
        cell.textLabel.font = FONT_Trebuchet_MS_15;
        cell.textLabel.backgroundColor=COLOR_CLEAR;
    }

    if (tableView == tblQuestionFilter) {
        int val = [[arrFilterType objectAtIndex:indexPath.row] intValue];
        cell.textLabel.text = [arrFilter objectAtIndex:indexPath.row];
        
        UILabel *lbl = [[UILabel alloc] init];
        [lbl setFrame:CGRectMake(tblQuestionFilter.frame.size.width - 70, 11, 40, 20)];
        lbl.backgroundColor = COLOR_BLUE_FILTER;
        lbl.textColor = COLOR_WHITE;
        lbl.font = FONT_Trebuchet_MS_13;
        lbl.textAlignment = UITextAlignmentCenter;
        lbl.text = [NSString stringWithFormat:@"%d", val];
        [lbl.layer setCornerRadius:10.0];
        [cell.contentView addSubview:lbl];
        [arrCounterLabel addObject:lbl];
        
        if (val == 0) {
            lbl.backgroundColor = COLOR_CLEAR;
            lbl.text = @"";
        }
        
        if ([arrSelectedCellsFilter containsObject:indexPath]) {
            [tblQuestionFilter selectRowAtIndexPath:indexPath animated:NO scrollPosition:NO];
            if (currentOrientaion == 1 || currentOrientaion == 2)
                cell.contentView.backgroundColor = row_color_selected_p;
            else
                cell.contentView.backgroundColor = row_color_selected_l;
            
        }
        else {
            cell.contentView.backgroundColor = row_color_l;
        }
        
        
    }
    else if(tableView == tblTopics) {
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Select All";
        }
        else {
            Chapters *objChap = (Chapters *)[chapterDbData objectAtIndex:indexPath.row-1];
            cell.textLabel.text = objChap.strChapterTitle;
        }
        
        if ([arrSelectedCells containsObject:indexPath]) {
            [tblTopics selectRowAtIndexPath:indexPath animated:NO scrollPosition:NO];
            if (currentOrientaion == 1 || currentOrientaion == 2)
                cell.contentView.backgroundColor = row_color_selected_p;
            else
                cell.contentView.backgroundColor = row_color_selected_l;
        }
        else {
            cell.contentView.backgroundColor = row_color_l;            
        }
       
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (currentOrientaion == 1 || currentOrientaion == 2)
        cell.contentView.backgroundColor = row_color_selected_p;
    else
        cell.contentView.backgroundColor = row_color_selected_l;
    
    cell.selected = YES;
    
    if (indexPath.row == 0) {
        
        if (tableView == tblQuestionFilter) {
            NSArray *arrTemp = [tblQuestionFilter indexPathsForVisibleRows];
            for (NSIndexPath *index in arrTemp) {
                [tblQuestionFilter selectRowAtIndexPath:index animated:NO scrollPosition:NO];
                cell = [tblQuestionFilter cellForRowAtIndexPath:index];
                if (currentOrientaion == 1 || currentOrientaion == 2)
                    cell.contentView.backgroundColor = row_color_selected_p;
                else
                    cell.contentView.backgroundColor = row_color_selected_l;
            }
        }
        else if (tableView == tblTopics) {
            for (int i=0; i<chapterDbData.count;i++) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:i+1 inSection:0];
                cell = [tblTopics cellForRowAtIndexPath:index];
                if (currentOrientaion == 1 || currentOrientaion == 2)
                    cell.contentView.backgroundColor = row_color_selected_p;
                else
                    cell.contentView.backgroundColor = row_color_selected_l;
                cell.selected = YES;
                [tblTopics selectRowAtIndexPath:index animated:NO scrollPosition:NO];
                
            }
        }
        
    }
    else {
        
        if (tableView == tblQuestionFilter) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            cell = [tblQuestionFilter cellForRowAtIndexPath:index];
            if (cell.selected) {
                [tblQuestionFilter deselectRowAtIndexPath:index animated:NO];
                cell.contentView.backgroundColor = row_color_l;
                cell.selected = NO;
            }
            
        }
        else if (tableView == tblTopics) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            cell = [tblTopics cellForRowAtIndexPath:index];
            if (cell.selected) {
                [tblTopics deselectRowAtIndexPath:index animated:NO];
                cell.contentView.backgroundColor = row_color_l;
                cell.selected = NO;
            }
        }
    }
    
    [self fnSetQuestionsCount];
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = row_color_l;
    cell.selected = NO;
    
    if (indexPath.row == 0) {
        
        if (tableView == tblQuestionFilter) {
            NSArray *arrTemp = [tblQuestionFilter indexPathsForVisibleRows];
            for (NSIndexPath *index in arrTemp) {
                [tblQuestionFilter deselectRowAtIndexPath:index animated:NO];
                cell = [tblQuestionFilter cellForRowAtIndexPath:index];
                cell.contentView.backgroundColor = row_color_l;
            }
        }
        else if (tableView == tblTopics) {
            for (int i=0; i<chapterDbData.count;i++) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:i+1 inSection:0];
                [tblTopics deselectRowAtIndexPath:index animated:NO];
                cell = [tblTopics cellForRowAtIndexPath:index];
                cell.contentView.backgroundColor = row_color_l;
                cell.selected = NO;
            }
        }
        
    }
    else {
        if (tableView == tblQuestionFilter) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            cell = [tblQuestionFilter cellForRowAtIndexPath:index];
            if (cell.selected) {
                [tblQuestionFilter deselectRowAtIndexPath:index animated:NO];
                cell.contentView.backgroundColor = row_color_l;
                cell.selected = NO;
            }
            
        }
        else if (tableView == tblTopics) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            [tblTopics deselectRowAtIndexPath:index animated:NO];
            cell = [tblTopics cellForRowAtIndexPath:index];
            cell.contentView.backgroundColor = row_color_l;
            cell.selected = NO;
        }
    }
    
    [self fnSetQuestionsCount];
}
//-----------------------------------------


#pragma mark - Rotations
//-----------------------------------------
-(BOOL) shouldAutorotate
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
    currentOrientaion = interfaceOrientation;    
    if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft){
        [self fnRotateLandscape];
        
        mask  |= UIInterfaceOrientationMaskLandscapeLeft;
        
    }
    else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        [self fnRotateLandscape];
        mask |= UIInterfaceOrientationMaskLandscapeRight;
        
	}
	else if(interfaceOrientation==UIInterfaceOrientationPortrait){
        [self fnRotatePortrait];
        mask  |=UIInterfaceOrientationMaskPortraitUpsideDown;
        
	}
	else {
        [self fnRotatePortrait];
        mask  |=UIInterfaceOrientationMaskPortrait;
        
	}
    return UIInterfaceOrientationMaskAll;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        return NO;
    }
    currentOrientaion = interfaceOrientation;
    if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft){
        [self fnRotateLandscape];
        return YES;
    }
    else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
		[self fnRotateLandscape];
        return YES;
	}
	else if(interfaceOrientation==UIInterfaceOrientationPortrait){
		[self fnRotatePortrait];
        return YES;
	}
	else {
        [self fnRotatePortrait];
        return YES;
	}
    
	return YES;
}

-(void)fnRotatePortrait
{
    //self.view.frame = CGRectMake(0, 0, 768, 1024);
    
    [imgViewBg setImage:[UIImage imageNamed:@"Img_View_TextureBg_P.png"]];
    [imgViewBg setFrame:CGRectMake(0, 0, 768, 960)];
    [viewBgPatch setFrame:CGRectMake(35,49,700,844)];
    [lblEnterQuizName setFrame:CGRectMake(66,64,300, 21)];
    [txtQuizNameInput setFrame:CGRectMake(66,95,637, 30)];
    
    [scrollView setFrame:CGRectMake(66,140, 637, 605)];
    [lblQuestionFilter setFrame:CGRectMake(0, 0, 300, 21) ];
    [tblQuestionFilter setFrame:CGRectMake(0, 28, 637, 205) ];
    [lblSelectedTopics setFrame:CGRectMake(0, 249, 300, 21) ];
    [tblTopics setFrame:CGRectMake(0, 277, 637, (41*chapterDbData.count)+41)];
    float h_ = lblQuestionFilter.frame.size.height+tblQuestionFilter.frame.size.height+lblSelectedTopics.frame.size.height+tblTopics.frame.size.height+35;
    [scrollView setContentSize:CGSizeMake(637, h_)];
    
    [switchTimer setFrame:CGRectMake(185,768,50,26)];
    [lblTimer  setFrame:CGRectMake(66,768,120,26)];
    
    
    [sliderQuestions setFrame:CGRectMake(66,845,280,23)];
    [lblSelectedQuestions setFrame:CGRectMake(66,808,312,26)];
    [lblSelectedQuestionsCount setFrame:CGRectMake(291,808,91,26)];
    [customButton_BnBegin setFrame:CGRectMake(530, 835, 176, 39)];
    [customButton_BnClear setFrame:CGRectMake(350, 835, 176, 39)];
    [Title setFrame:CGRectMake(184, 0, 400, 44)];
    
    [self fnChangeTickmarkSizes];
    
}

-(void)fnRotateLandscape
{
    //self.view.frame = CGRectMake(0, 0, 1024, 768);
    
    [imgViewBg setImage:[UIImage imageNamed:@"Img_View_TextureBg.png"]];
    [imgViewBg setFrame:CGRectMake(0, 0, 1024, 704)];
    [viewBgPatch setFrame:CGRectMake(71,32, 882, 640)];
    [lblEnterQuizName setFrame:CGRectMake(99, 47, 300, 21) ];
    [txtQuizNameInput setFrame:CGRectMake(99, 73, 825, 30) ];
    
    [scrollView setFrame:CGRectMake(99,117, 825, 400)];
    [lblQuestionFilter setFrame:CGRectMake(0, 0, 300, 21) ];
    [tblQuestionFilter setFrame:CGRectMake(0, 28, 825, 205) ];
    [lblSelectedTopics setFrame:CGRectMake(0, 249, 300, 21) ];
    [tblTopics setFrame:CGRectMake(0, 277, 825, (41*chapterDbData.count)+41)];
    float h_ = lblQuestionFilter.frame.size.height+tblQuestionFilter.frame.size.height+lblSelectedTopics.frame.size.height+tblTopics.frame.size.height+35;
    [scrollView setContentSize:CGSizeMake(825, h_)];
    
    [lblTimer  setFrame:CGRectMake(99,543,120,26)];
    [switchTimer setFrame:CGRectMake(220,542,50,26)];

    [lblSelectedQuestions setFrame:CGRectMake(99, 587, 665, 26) ];
    [lblSelectedQuestionsCount setFrame:CGRectMake(323, 587, 91, 26)];
    [sliderQuestions setFrame:CGRectMake(99, 624, 456, 23) ];
    [customButton_BnBegin setFrame:CGRectMake(751, 617, 176, 39)];
    [customButton_BnClear setFrame:CGRectMake(564, 617, 176, 39)];
    [Title setFrame:CGRectMake(312, 0, 400, 44)];
    
    [self fnChangeTickmarkSizes];
}
//-----------------------------------------

@end
