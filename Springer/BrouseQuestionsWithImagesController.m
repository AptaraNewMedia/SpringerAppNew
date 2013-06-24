//
//  QuestionsWithImagesController.m
//  Springer1.1
//
//  Created by PUN-MAC-012 on 06/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "BrouseQuestionsWithImagesController.h"
#import "Questions.h"
#import <QuartzCore/QuartzCore.h>
#import "BrouseQuestionSetViewController.h"

#import "QuestionTemplateCell.h"

@interface BrouseQuestionsWithImagesController ()
{
    IBOutlet UILabel *lblQuestion;
    IBOutlet UITableView *tblOptions;
    IBOutlet UIButton *btnSubmit;

    IBOutlet UIImageView *imageView;
    IBOutlet UIImageView *imgQuestionBG;
    IBOutlet UIImageView *imgBG;

    IBOutlet UIPageControl *pageControl;
    IBOutlet UIScrollView *scorllViewImages;
    IBOutlet UIWebView *webViewQuestion;
    IBOutlet UIImageView *imgTblLast;
    IBOutlet UIView *view_image;
    IBOutlet UIView *view_Rationale;
   

    Questions *objCurrentQuestion;
   
    int intCorrectIncorrect;
    int int_Table_width;
    int int_view_widih;
    int int_tbl_hight;
    int int_LPMode;
    int int_spaceImgTable;
    int currentOrientation;
    float Rational_max_y;
    
    NSMutableArray *optionsSize;
    NSMutableDictionary *dicSize;
    NSString *SelectedAnswer;
    NSString *StrImageName;

    
    NSMutableArray *array_Cell;
    
    BOOL ShowAnswer;
    
    id parentObject;
    int checkShowAnswer;
    float rational_l;
    float rational_p;
    UIWebView *web_View_rational;
    BOOL ShowRational;
    int checkShowRational;
    
    QuestionTemplateCell *cell;
 
    UIView *viewZoom;
    UIImage *img_Original;
    
    NSInteger previousOrientation;
}

-(void)fnSetFontColor;
-(void)fnSetVariables;
-(void)fnCalculateSize;
-(void)fnSetUISize;
-(float)getSize:(NSString *)str AndWidth:(float)width;

@end

@implementation BrouseQuestionsWithImagesController

@synthesize strSelectedAnswer;
//@synthesize ShowAnswer;

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
    // Do any additional setup after loading the view from its nib.

    [self fnCalculateSize];    
    [self fnSetFontColor];
    [self fnSetVariables];
    [self fnCreateImagesSet];
    [self fnSetUISize];
    [self createRationale];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-----------------------------------------


//pragma mark - Normal Functions
//-----------------------------------------
-(void)fnSetData:(Questions *)objQuestionData AndShowAnswer:(BOOL)answer AndParentObject:(id)parentobject AndRational:(BOOL)rational
{
    objCurrentQuestion = objQuestionData;
    ShowAnswer = answer;
    parentObject = parentobject;
    ShowRational = rational;    

}

-(int)fnCheckAnswer
{
    if ([SelectedAnswer isEqualToString: [NSString stringWithFormat:@"NA"] ])
    {
        intCorrectIncorrect = 0;
    }
    else {
        
        if ([SelectedAnswer isEqualToString:objCurrentQuestion.strStrokeAnswer]){
            intCorrectIncorrect = 1;
        }
        else {
            intCorrectIncorrect = 2;
        }
    }
    return intCorrectIncorrect;
}

-(void)fnDisableTable
{
   tblOptions.userInteractionEnabled = NO;
}

-(void)fnSetFontColor
{
    lblQuestion.font = FONT_Trebuchet_MS_14;
    lblQuestion.textColor = COLOR_BLACK_Rgb;
    
    tblOptions.backgroundColor = COLOR_WHITE;

}

-(void)fnSetVariables
{
    int_spaceImgTable = 25;
    webViewQuestion.opaque = NO;    
    [webViewQuestion loadHTMLString:[NSString stringWithFormat: @"<html><body style=\"font-size:14px;font-family:Trebuchet MS;font-color:#333333;padding-left:20px;padding-top:5px;padding-Right:20px;\">%@</body></html>",objCurrentQuestion.strQuestionText] baseURL:nil];
    if (DEVICE_VERSION>CURRENT_VERSION) {
        webViewQuestion.scrollView.userInteractionEnabled = NO;
    }
    else
    {
        webViewQuestion.userInteractionEnabled=NO;
    }
    
    tblOptions.scrollEnabled = NO;
    SelectedAnswer = @"NA";
    
    array_Cell = [[NSMutableArray alloc] init];
    checkShowAnswer = 0;
    
    if (ShowAnswer) {
        tblOptions.allowsSelection = NO;
    }
}

-(void)fnCalculateSize
{
    optionsSize = [[NSMutableArray alloc] init];
    NSMutableDictionary *arr;
    
    //Question
    float ipad_l_size = [self getSize:objCurrentQuestion.strQuestionText AndWidth:1000];
    float ipad_p_size = [self getSize:objCurrentQuestion.strQuestionText AndWidth:748];
    arr = [[NSMutableDictionary alloc] init];
    [arr setObject:[NSNumber numberWithFloat:1024] forKey:@"L_WIDTH"];
    [arr setObject:[NSNumber numberWithFloat:ipad_l_size] forKey:@"L_SIZE"];
    [arr setObject:[NSNumber numberWithFloat:768] forKey:@"P_WIDTH"];
    [arr setObject:[NSNumber numberWithFloat:ipad_p_size] forKey:@"P_SIZE"];
    [optionsSize addObject:arr];
    
    //Options
    for (int i =0; i < objCurrentQuestion.arrOptions.count ; i++) {
        float o_width;
        if (objCurrentQuestion.arrImagePaths.count >= 1) {
            ipad_l_size = [self getSizeOptions:[objCurrentQuestion.arrOptions objectAtIndex:i] AndWidth:600];
            o_width = 652;
        }
        else {
            ipad_l_size = [self getSizeOptions:[objCurrentQuestion.arrOptions objectAtIndex:i] AndWidth:900];
            o_width = 948;
        }
        ipad_p_size = [self getSizeOptions:[objCurrentQuestion.arrOptions objectAtIndex:i] AndWidth:600];
        
        arr = [[NSMutableDictionary alloc] init];
        [arr setObject:[NSNumber numberWithFloat:o_width] forKey:@"L_WIDTH"];
        [arr setObject:[NSNumber numberWithFloat:ipad_l_size] forKey:@"L_SIZE"];
        [arr setObject:[NSNumber numberWithFloat:694] forKey:@"P_WIDTH"];
        [arr setObject:[NSNumber numberWithFloat:ipad_p_size] forKey:@"P_SIZE"];
        [optionsSize addObject:arr];
        
    }
    
    //Rationale
    rational_l = [self getSizeRationale:objCurrentQuestion.strFeedback AndWidth:1004];
    rational_p = [self getSizeRationale:objCurrentQuestion.strFeedback AndWidth:748];
}

-(void)fnSetUISize
{
    
    
    float width_ ;
    float height_;
    
    // Question
    dicSize = [optionsSize objectAtIndex:0];
    if (currentOrientation == 1 || currentOrientation == 2) {
        width_ = [[dicSize objectForKey:@"P_WIDTH"] floatValue];
        height_ = [[dicSize objectForKey:@"P_SIZE"] floatValue];
    }
    else {
        width_ = [[dicSize objectForKey:@"L_WIDTH"] floatValue];
        height_ = [[dicSize objectForKey:@"L_SIZE"] floatValue];
    }
    
    [webViewQuestion setFrame:CGRectMake(0, 0, width_, height_)];
    [imgQuestionBG setFrame:CGRectMake(0, height_ - 10, width_,34)];
    
    
    //Options
    float option_total_height = 0;
    float tbl_x;
    float Img_x;
    
    
    if (objCurrentQuestion.arrOptions.count > 1) {
        dicSize = [optionsSize objectAtIndex:1];
        if (currentOrientation == 1 || currentOrientation == 2) {
            width_ = [[dicSize objectForKey:@"P_WIDTH"] floatValue];
            height_ = [[dicSize objectForKey:@"P_SIZE"] floatValue];
            tbl_x  = 37;
            if (objCurrentQuestion.arrImagePaths.count >= 1) {
                Img_x=241;
            }
            
            
        }
        else {
            width_ = [[dicSize objectForKey:@"L_WIDTH"] floatValue];
            height_ = [[dicSize objectForKey:@"L_SIZE"] floatValue];
            
            tbl_x = 38;
            if (objCurrentQuestion.arrImagePaths.count >= 1) {
                tbl_x = 334;
                Img_x = 38;            }
            
        }
        
        for (int i =0; i < objCurrentQuestion.arrOptions.count; i++) {
            dicSize = [optionsSize objectAtIndex:i+1];
            if (currentOrientation == 1 || currentOrientation == 2) {
                height_ = [[dicSize objectForKey:@"P_SIZE"] floatValue];
            }
            else {
                height_ = [[dicSize objectForKey:@"L_SIZE"] floatValue];
            }
            option_total_height = option_total_height + height_;
        }
        
        
        
        if (objCurrentQuestion.arrImagePaths.count >= 1 && (currentOrientation == 1 || currentOrientation == 2) )
        {
            view_image.hidden=NO;
            [view_image setFrame:CGRectMake(Img_x, imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, view_image.frame.size.width, view_image.frame.size.height)];
            [tblOptions setFrame:CGRectMake(tbl_x ,imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable+270, width_, option_total_height)];
            [imgTblLast setFrame:CGRectMake(tbl_x,tblOptions.frame.origin.y+tblOptions.frame.size.height,width_,12)];
            [imgTblLast setImage:[UIImage imageNamed:@"Img_View_Option1Bg_P.png"]];
        }
        else if (objCurrentQuestion.arrImagePaths.count >= 1 && (currentOrientation == 3 || currentOrientation == 4) )
        {
            view_image.hidden=NO;
            
            [view_image setFrame:CGRectMake(Img_x, imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, view_image.frame.size.width, view_image.frame.size.height)];
            [tblOptions setFrame:CGRectMake(tbl_x ,imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, width_, option_total_height)];
            [imgTblLast setFrame:CGRectMake(tbl_x,tblOptions.frame.origin.y+tblOptions.frame.size.height,width_,14)];
            [imgTblLast setImage:[UIImage imageNamed:@"Img_View_Option1Bg.png"]];
        }
        else if ( (currentOrientation == 1 || currentOrientation == 2) )
        {
            view_image.hidden=YES;
            [tblOptions setFrame:CGRectMake(tbl_x ,imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, width_, option_total_height)];
            [imgTblLast setFrame:CGRectMake(tbl_x,tblOptions.frame.origin.y+tblOptions.frame.size.height,width_,12)];
            [imgTblLast setImage:[UIImage imageNamed:@"Img_View_Option1Bg_P.png"]];
        }
        else
        {
            view_image.hidden=YES;
            [tblOptions setFrame:CGRectMake(tbl_x ,imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, width_, option_total_height)];
            [imgTblLast setFrame:CGRectMake(tbl_x,tblOptions.frame.origin.y+tblOptions.frame.size.height,width_,14)];
            [imgTblLast setImage:[UIImage imageNamed:@"Img_View_Option2Bg.png"]];
        }
    }
   

    if (view_Rationale.hidden) {
        if (currentOrientation == 1 || currentOrientation == 2) {
            view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x, 1024, 768, 1024 - tblOptions.frame.origin.y);
            
        }
        else {
            view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x, 768, 1024, 768 - tblOptions.frame.origin.y);
        }
    }
    else {
        if (currentOrientation == 1 || currentOrientation == 2) {
            view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x, tblOptions.frame.origin.y, 768, 1024 - tblOptions.frame.origin.y);
            web_View_rational.frame = CGRectMake(35, 10, 690, view_Rationale.frame.size.height - 50);
        }
        else {
            view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x,  tblOptions.frame.origin.y, 1024, 768 - tblOptions.frame.origin.y);
            web_View_rational.frame = CGRectMake(35, 10, 954, view_Rationale.frame.size.height - 50);
        }
    }

}

-(void)fnCreateImagesSet
{
    int x=0;
    for (int int_bulet=0; int_bulet<[objCurrentQuestion.arrImagePaths count]; int_bulet++)
    {
        UIView *bg = [[UIView alloc] init];
        [bg setFrame:CGRectMake(x, 0, 286, 213)];
        bg.backgroundColor = COLOR_WHITE;
        img_Original = [UIImage imageNamed:[objCurrentQuestion.arrImagePaths objectAtIndex:int_bulet]];
        
        //
        StrImageName=[[NSString alloc]init];
        StrImageName=[objCurrentQuestion.arrImagePaths objectAtIndex:int_bulet];
        
        //UIImage *imgModified = [self imageWithImage:img_Original scaledToWidth:266];
        UIImageView *ima_images=[[UIImageView alloc]initWithFrame:CGRectMake(10+x, 10, 266, 193)];
        ima_images.backgroundColor = COLOR_WHITE;
        ima_images.image=img_Original;
        if (img_Original.size.width > 266 || img_Original.size.height > 193) {
            ima_images.contentMode = UIViewContentModeScaleAspectFit;
        }
        else {
            ima_images.contentMode = UIViewContentModeCenter;
        }
        x=x+286;
        UIButton *bnInvisible = [UIButton buttonWithType:UIButtonTypeCustom];
        [bnInvisible setFrame:bg.frame];
        bnInvisible.tag = int_bulet;
        bnInvisible.backgroundColor = COLOR_CLEAR;
        [bnInvisible addTarget:self action:@selector(fnAnimateZoomInImage) forControlEvents:UIControlEventTouchUpInside];
        [scorllViewImages addSubview:bg];
        [scorllViewImages addSubview:ima_images];
        [scorllViewImages addSubview:bnInvisible];
        if ([objCurrentQuestion.arrImagePaths count]==1) {
            pageControl.hidden=YES;
        }
        else
        {
            pageControl.hidden=NO;
        }
    }
    
    scorllViewImages.layer.masksToBounds = NO;
    scorllViewImages.layer.cornerRadius = 0;
    scorllViewImages.layer.shadowRadius = 1.5;
    scorllViewImages.layer.shadowOpacity = 0.3;
    scorllViewImages.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 5, scorllViewImages.frame.size.width-2, scorllViewImages.frame.size.height-2.5)].CGPath;
    
    scorllViewImages.delegate=self;
    scorllViewImages.contentSize=CGSizeMake(266*[objCurrentQuestion.arrImagePaths count], 193);
    scorllViewImages.pagingEnabled=YES;
    
    [pageControl addTarget:self action:@selector(clickPageControl) forControlEvents:UIControlEventTouchUpInside];
    pageControl.numberOfPages=[objCurrentQuestion.arrImagePaths count];
    pageControl.currentPage=0;

}



-(void)fnAnimateZoomInImage
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         viewZoom.hidden = NO;
     }
     completion:^(BOOL finished)
     {
         [md Fn_ZoomImgWithView:StrImageName];
     }];
}

-(void)fnAnimateZoomOutImage
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
     }
     completion:^(BOOL finished)
     {
         viewZoom.hidden = YES;
     }];
}

-(UIImage*)imageWithImage: (UIImage*)sourceImage scaledToWidth:(float)i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(float)getSize:(NSString *)str AndWidth:(float)width
{
    
    CGSize constraintSiz = CGSizeMake(width, 10000.0f);
    CGSize labelSiz = [str sizeWithFont:FONT_Trebuchet_MS_15 constrainedToSize:constraintSiz lineBreakMode:UILineBreakModeWordWrap];
//    if (labelSiz.height < 40) {
//        labelSiz.height = 40;
//    }
//    else {
        labelSiz.height = labelSiz.height + 15;
//    }
    return labelSiz.height;
}

-(float)getSizeOptions:(NSString *)str AndWidth:(float)width
{
    
    CGSize constraintSiz = CGSizeMake(width, 5000.0f);
    CGSize labelSiz = [str sizeWithFont:FONT_Trebuchet_MS_16 constrainedToSize:constraintSiz lineBreakMode:UILineBreakModeWordWrap];
    if (labelSiz.height < 40) {
        labelSiz.height = 40;
    }
    else {
        labelSiz.height = labelSiz.height + 10;
    }
    return labelSiz.height;
}

-(float)getSizeRationale:(NSString *)str AndWidth:(float)width
{
    
    CGSize constraintSiz = CGSizeMake(width, 50000.0f);
    CGSize labelSiz = [str sizeWithFont:FONT_Trebuchet_MS_14 constrainedToSize:constraintSiz lineBreakMode:UILineBreakModeWordWrap];
    if (labelSiz.height < 60) {
        labelSiz.height = 60+20;
    }
    else if (labelSiz.height == 60) {
        labelSiz.height = 100+40;
    }
    else
    {
       labelSiz.height =labelSiz.height+30;
    }
    return labelSiz.height;

}

-(void) fnCallParentForSaveSelectedAnser:(int)row
{
    char letter = (char) row + 65;
    strSelectedAnswer = [NSString stringWithFormat:@"%c",letter];
    SelectedAnswer = [NSString stringWithFormat:@"%c",letter];
    [parentObject fnUpdateQuizScore];
}
//-----------------------------------------


#pragma mark - Public Actions
//-----------------------------------------
-(void)clickPageControl
{
    int page=pageControl.currentPage;
    CGRect frame=scorllViewImages.frame;
    frame.origin.x=frame.size.width*page;
    frame.origin.y=0;
    [scorllViewImages scrollRectToVisible:frame animated:YES];
}

-(void)CheckAnswer
{
    checkShowAnswer = 1;
    for(int  i = 0;i<[array_Cell count];i++)
    {
        [[array_Cell objectAtIndex:i] setHidden:NO];
    }
    
    tblOptions.allowsSelection = NO;
  
    [parentObject fnUpdateQuizScore];
}

-(int) fnShowAnswer
{
    return checkShowAnswer;
}

-(int) fnCheckRational
{
    return checkShowRational;
}

-(void)createRationale
{
    float y_ ;
    
    [view_Rationale removeFromSuperview];
    
    web_View_rational = [[UIWebView alloc] init];
    if (DEVICE_VERSION>CURRENT_VERSION)
    {
        web_View_rational.scrollView.bounces = NO;
    }
    else
    {
        [(UIScrollView *)[[web_View_rational subviews] lastObject] setBounces:NO];
    }
    
    y_ = 550 - rational_l;
    
    web_View_rational.frame = CGRectMake(0, 0, 1024, rational_l);
    web_View_rational.backgroundColor = COLOR_TEXT_WHITE;
    web_View_rational.opaque = NO;
    view_Rationale = [[UIView alloc] initWithFrame:CGRectMake(0,  y_, 1024, rational_l)];
    view_Rationale.backgroundColor = COLOR_TEXT_WHITE;
    
    if (!ShowRational) {
        view_Rationale.hidden = YES;
    }
    
    [view_Rationale addSubview:web_View_rational];
    [self.view addSubview:view_Rationale];
    
    
    if (currentOrientation == 1 || currentOrientation == 2) {
        view_Rationale.frame = CGRectMake(0, tblOptions.frame.origin.y, 768, 1024 - tblOptions.frame.origin.y);
        web_View_rational.frame = CGRectMake(35, 10, 690, view_Rationale.frame.size.height - 50);
    }
    else {
        view_Rationale.frame = CGRectMake(0,  tblOptions.frame.origin.y, 1024, 768 - tblOptions.frame.origin.y);
        web_View_rational.frame = CGRectMake(35, 10, 954, view_Rationale.frame.size.height - 50);
    }
    
    
    view_Rationale.backgroundColor = COLOR_TEXT_WHITE;
    CALayer *layer_RationalView = [view_Rationale layer];
    [layer_RationalView setCornerRadius:6.0];
    
    [web_View_rational loadHTMLString:[NSString stringWithFormat: @"<html><body style=\"font-size:14px;font-family:Trebuchet MS;font-color:#333333;\">%@</body></html>",objCurrentQuestion.strFeedback] baseURL:nil];
}

-(void)Rationale
{
    
    if (view_Rationale.hidden) {
        if (currentOrientation == 1 || currentOrientation == 2) {
            view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x, 1024, view_Rationale.frame.size.width, 1024 - tblOptions.frame.origin.y);
            web_View_rational.frame = CGRectMake(35, 10, 690, view_Rationale.frame.size.height - 50);
            
        }
        else {
            view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x, 768, view_Rationale.frame.size.width, 768 - tblOptions.frame.origin.y);
            web_View_rational.frame = CGRectMake(35, 10, 954, view_Rationale.frame.size.height - 50);
        }
    }
    else {
        if (currentOrientation == 1 || currentOrientation == 2) {
            view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x, view_Rationale.frame.origin.y, 768, 1024 - tblOptions.frame.origin.y);
            web_View_rational.frame = CGRectMake(35, 10, 690, view_Rationale.frame.size.height - 50);
            
        }
        else {
            view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x, view_Rationale.frame.origin.y, 1024, 768 - tblOptions.frame.origin.y);
            web_View_rational.frame = CGRectMake(35, 10, 954, view_Rationale.frame.size.height - 50);
        }
    }
    
    
    if (view_Rationale.hidden) {
        view_Rationale.hidden = !view_Rationale.hidden;
        
        checkShowRational = 1;
        [parentObject fnUpdateQuizScore];
        
        [UIView animateWithDuration:0.7
                              delay:0.0
                            options: UIViewAnimationCurveEaseIn
                         animations:^{
                             view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x, tblOptions.frame.origin.y, view_Rationale.frame.size.width, view_Rationale.frame.size.height);
                         }
                         completion:^(BOOL finished){
                         }];
    }
    else {
        
        checkShowRational = 0;
        [parentObject fnUpdateQuizScore];
        
        [UIView animateWithDuration:0.9
                              delay:0.0
                            options: UIViewAnimationCurveEaseIn
                         animations:^{
                             if (currentOrientation == 1 || currentOrientation == 2) {
                                 view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x, 1024, view_Rationale.frame.size.width, 1024 - tblOptions.frame.origin.y);
                                 
                             }
                             else {
                                 view_Rationale.frame = CGRectMake(view_Rationale.frame.origin.x, 768, view_Rationale.frame.size.width, 768 - tblOptions.frame.origin.y);
                             }
                         }
                         completion:^(BOOL finished){
                             view_Rationale.hidden = !view_Rationale.hidden;
                         }];
    }
    
}
//-----------------------------------------


#pragma mark - Table View
//---------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [objCurrentQuestion.arrOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    float rowHeight;
    float width_;
    dicSize = [optionsSize objectAtIndex:indexPath.row+1];
    if (currentOrientation == 1 || currentOrientation == 2) {
        width_ = [[dicSize objectForKey:@"P_WIDTH"] floatValue];
        rowHeight = [[dicSize objectForKey:@"P_SIZE"] floatValue];
    }
    else {
        width_ = [[dicSize objectForKey:@"L_WIDTH"] floatValue];
        rowHeight = [[dicSize objectForKey:@"L_SIZE"] floatValue];
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[QuestionTemplateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellWidth:width_ rowHeight:rowHeight isBrowse:YES];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    
    char letter = (char) indexPath.row + 65;
    cell.lbl_AnsNo.text=[NSString stringWithFormat:@"%c",letter];
    [cell.web_option loadHTMLString:[NSString stringWithFormat: @"<html><body style=\"font-size:14px;font-family:Trebuchet MS;font-color:#333333;\">%@</body></html>",[objCurrentQuestion.arrOptions objectAtIndex:indexPath.row]] baseURL:nil];
    if ([strSelectedAnswer isEqualToString:[NSString stringWithFormat:@"%c", letter]])
    {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        cell.selection_View.backgroundColor = COLOR_TEMPLATE_ROW;
    }
        
    if (ShowAnswer) {
        cell.img_answer.hidden = NO;
    }
    else {
        cell.img_answer.hidden = YES;
    }

    
    //Check Answer
    //
    if ([objCurrentQuestion.strStrokeAnswer isEqualToString:[NSString stringWithFormat:@"%c",letter]])
    {
        [cell.img_answer setImage:[UIImage imageNamed:@"Img_Tick.png"]];
        [cell.img_answer setFrame:CGRectMake(width_-50, 7, 30, 23)];
    }
    else
    {
        [cell.img_answer setImage:[UIImage imageNamed:@"Img_Cross.png"]];
        [cell.img_answer setFrame:CGRectMake(width_-50, 7, 23, 23)];
        
    }
    
    [array_Cell addObject:cell.img_answer];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (QuestionTemplateCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selection_View.backgroundColor = COLOR_TEMPLATE_ROW;    
    [self fnCallParentForSaveSelectedAnser:indexPath.row];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (QuestionTemplateCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selection_View.backgroundColor = COLOR_CLEAR;    
    [self fnCallParentForSaveSelectedAnser:indexPath.row];
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight;
    dicSize = [optionsSize objectAtIndex:indexPath.row+1];
    if (currentOrientation == 1 || currentOrientation == 2) {
        rowHeight = [[dicSize objectForKey:@"P_SIZE"] floatValue];
    }
    else {
        rowHeight = [[dicSize objectForKey:@"L_SIZE"] floatValue];
    }
    return rowHeight;
}
//---------------------------------------------------------


#pragma mark - Scroll Delegate
//---------------------------------------------------------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == scorllViewImages) {
        int page = scrollView.contentOffset.x/scrollView.frame.size.width;
        pageControl.currentPage=page;
    }
}
//-----------------------------------------


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
    currentOrientation = interfaceOrientation;
//    if (previousOrientation != currentOrientation) {
//        [self fnCalculateSize];
//        [self fnSetUISize];
//        [self fnCreateZoomImage];
//    }
//    previousOrientation = currentOrientation;
    
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
    currentOrientation = interfaceOrientation;
//    if (previousOrientation != currentOrientation) {
//        [self fnCalculateSize];
//        [self fnSetUISize];
//        [self fnCreateZoomImage];
//    }
//    previousOrientation = currentOrientation;
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
    [self.view setFrame:CGRectMake(0,0,768,900)];
    [imgBG setFrame:CGRectMake(0,0,768,900)];
    [imgBG setImage:[UIImage imageNamed:@"Img_Question_texture_p.png"]];
    [imgQuestionBG setImage:[UIImage imageNamed:@"Img_View_QuestionBg_P.png"]];
    [self fnCalculateSize];
    [self fnSetUISize];
}

-(void)fnRotateLandscape
{
    [self.view setFrame:CGRectMake(0,0,1024,644)];
    [imgBG setImage:[UIImage imageNamed:@"Img_Question_texture.png"]];
    [imgBG setFrame:CGRectMake(0,0,1024,644)];
    [imgQuestionBG setImage:[UIImage imageNamed:@"Img_View_QuestionBg.png"]];
    [self fnCalculateSize];
    [self fnSetUISize];
}
//---------------------------------------------------------

@end
