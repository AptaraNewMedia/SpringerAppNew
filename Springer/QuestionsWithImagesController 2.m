//
//  QuestionsWithImagesController.m
//  Springer1.1
//
//  Created by PUN-MAC-012 on 06/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "QuestionsWithImagesController.h"
#import "Questions.h"
@interface QuestionsWithImagesController ()
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
    
    Questions *objCurrentQuestion;
   
    int intCorrectIncorrect;
    int int_Table_width;
    int int_view_widih;
    int int_tbl_hight;
    int int_LPMode;
    int int_spaceImgTable;
    int currentOrientation;
    
    NSMutableArray *optionsSize;
    NSMutableDictionary *dicSize;
    NSString *SelectedAnswer;
}

-(void)fnSetFontColor;
-(void)fnSetVariables;
-(void)fnCalculateSize;
-(void)fnSetUISize;
-(float)getSize:(NSString *)str AndWidth:(float)width;

@end

@implementation QuestionsWithImagesController

@synthesize strSelectedAnswer;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self fnCalculateSize];    
    [self fnSetFontColor];
    [self fnSetVariables];
    int x=0;
    for (int int_bulet=0; int_bulet<[objCurrentQuestion.arrImagePaths count]; int_bulet++)
    {
        
        UIImageView *ima_images=[[UIImageView alloc]initWithFrame:CGRectMake(2+x, 0, 266, 193)];
        ima_images.Image=[UIImage imageNamed:[objCurrentQuestion.arrImagePaths objectAtIndex:int_bulet]];
        x=x+266;
        [scorllViewImages addSubview:ima_images];
    }
    
    scorllViewImages.delegate=self;
    scorllViewImages.contentSize=CGSizeMake(266*[objCurrentQuestion.arrImagePaths count], 193);
    scorllViewImages.pagingEnabled=YES;
    
    [pageControl addTarget:self action:@selector(clickPageControl) forControlEvents:UIControlEventTouchUpInside];
    pageControl.numberOfPages=[objCurrentQuestion.arrImagePaths count];
    pageControl.currentPage=0;
    
//    [self Fn_On_view_Load];
//    [self.view addSubview:imageView];
//    [self.view addSubview:pageControl];
//    [self.view addSubview:scorllViewImages];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-----------------------------------------


#pragma mark - Normal Functions
//-----------------------------------------
-(void)fnSetData:(Questions *)objQuestionData
{
    objCurrentQuestion = objQuestionData;
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

-(void)fnSetFontColor
{
    lblQuestion.font = FONT_Helvetica_17;
    lblQuestion.textColor = COLOR_BLACK;    
}

-(void)fnSetVariables
{
    int_spaceImgTable = 50;
    [webViewQuestion loadHTMLString:[NSString stringWithFormat: @"<html><body style=\"font-size:17px;font-family:helvetica;\">%@</body></html>",objCurrentQuestion.strQuestionText] baseURL:nil];
    webViewQuestion.scrollView.userInteractionEnabled = NO;
    tblOptions.scrollEnabled = NO;
    SelectedAnswer = @"NA";
}

-(void)fnCalculateSize
{
    optionsSize = [[NSMutableArray alloc] init];
    NSMutableDictionary *arr;
    
    //Question
    float ipad_l_size = [self getSize:objCurrentQuestion.strQuestionText AndWidth:1024];
    float ipad_p_size = [self getSize:objCurrentQuestion.strQuestionText AndWidth:768];
    arr = [[NSMutableDictionary alloc] init];
    [arr setObject:[NSNumber numberWithFloat:1024] forKey:@"L_WIDTH"];
    [arr setObject:[NSNumber numberWithFloat:ipad_l_size] forKey:@"L_SIZE"];
    [arr setObject:[NSNumber numberWithFloat:768] forKey:@"P_WIDTH"];
    [arr setObject:[NSNumber numberWithFloat:ipad_p_size] forKey:@"P_SIZE"];
    [optionsSize addObject:arr];

    //Options
    for (int i =0; i < objCurrentQuestion.arrOptions.count ; i++) {
        float o_width;
        if (objCurrentQuestion.arrImagePaths.count > 1) {
            ipad_l_size = [self getSize:[objCurrentQuestion.arrOptions objectAtIndex:i] AndWidth:600];
            o_width = 661;
        }
        else {
            ipad_l_size = [self getSize:[objCurrentQuestion.arrOptions objectAtIndex:i] AndWidth:900];
            o_width = 958;
        }
        ipad_p_size = [self getSize:[objCurrentQuestion.arrOptions objectAtIndex:i] AndWidth:600];
        
        arr = [[NSMutableDictionary alloc] init];
        [arr setObject:[NSNumber numberWithFloat:o_width] forKey:@"L_WIDTH"];
        [arr setObject:[NSNumber numberWithFloat:ipad_l_size] forKey:@"L_SIZE"];
        [arr setObject:[NSNumber numberWithFloat:674] forKey:@"P_WIDTH"];
        [arr setObject:[NSNumber numberWithFloat:ipad_p_size] forKey:@"P_SIZE"];
        [optionsSize addObject:arr];
        
    }
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
    [imgQuestionBG setFrame:CGRectMake(0, height_, width_,34)];
    

    //Options
    float option_total_height = 0;
    float tbl_x;
    float Img_x;

    
    if (objCurrentQuestion.arrOptions.count > 1) {
        dicSize = [optionsSize objectAtIndex:1];
        if (currentOrientation == 1 || currentOrientation == 2) {
            width_ = [[dicSize objectForKey:@"P_WIDTH"] floatValue];
            height_ = [[dicSize objectForKey:@"P_SIZE"] floatValue];
            tbl_x  = 40;
            if (objCurrentQuestion.arrImagePaths.count > 1) {
                Img_x=220;
            }
            
            
        }
        else {
            width_ = [[dicSize objectForKey:@"L_WIDTH"] floatValue];
            height_ = [[dicSize objectForKey:@"L_SIZE"] floatValue];
            
            tbl_x = 30;
            if (objCurrentQuestion.arrImagePaths.count > 1) {
                tbl_x = 330;
                Img_x=20;
            }
            
        }
        
        for (int i =0; i < objCurrentQuestion.arrOptions.count; i++) {
            dicSize = [optionsSize objectAtIndex:i+1];
            height_ = [[dicSize objectForKey:@"L_SIZE"] floatValue];
            option_total_height = option_total_height + height_;
        }
        
        
        if (option_total_height < 300) {
            option_total_height = 300;
        }
        
        
         if (objCurrentQuestion.arrImagePaths.count > 1 && (currentOrientation == 1 || currentOrientation == 2) )
         {
             view_image.hidden=NO;
        [view_image setFrame:CGRectMake(Img_x, imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, view_image.frame.size.width, view_image.frame.size.height)];
        [tblOptions setFrame:CGRectMake(tbl_x ,imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable+280, width_, option_total_height)];
        [imgTblLast setFrame:CGRectMake(tbl_x,tblOptions.frame.origin.y+tblOptions.frame.size.height,width_,28)];
        [imgTblLast setImage:[UIImage imageNamed:@"Img_View_Option2Bg.png"]];
         }
        else if (objCurrentQuestion.arrImagePaths.count > 1 && (currentOrientation == 3 || currentOrientation == 4) )
        {
            view_image.hidden=NO;

            [view_image setFrame:CGRectMake(Img_x, imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, view_image.frame.size.width, view_image.frame.size.height)];
            [tblOptions setFrame:CGRectMake(tbl_x ,imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, width_, option_total_height)];
            [imgTblLast setFrame:CGRectMake(tbl_x,tblOptions.frame.origin.y+tblOptions.frame.size.height,width_,28)];
            [imgTblLast setImage:[UIImage imageNamed:@"Img_View_Option2Bg.png"]];
        }
        else 
        {
            view_image.hidden=YES;
            [tblOptions setFrame:CGRectMake(tbl_x ,imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, width_, option_total_height)];
            [imgTblLast setFrame:CGRectMake(tbl_x,tblOptions.frame.origin.y+tblOptions.frame.size.height,width_,28)];
            [imgTblLast setImage:[UIImage imageNamed:@"Img_View_Option2Bg.png"]];
        }
    }
    
}

-(float)getSize:(NSString *)str AndWidth:(float)width
{
   
    CGSize constraintSiz = CGSizeMake(width, 10000.0f);
    CGSize labelSiz = [str sizeWithFont:FONT_Helvetica_18 constrainedToSize:constraintSiz lineBreakMode:UILineBreakModeWordWrap];
    if (labelSiz.height < 40) {
        labelSiz.height = 40;
    }
    else {
        labelSiz.height = labelSiz.height + 10;
    }
    return labelSiz.height;
}

/*
-(void)Fn_On_view_Load
{
    
    
    CGSize constraintSiz = CGSizeMake(int_view_widih-14, 10000.0f);
    CGSize labelSiz = [objCurrentQuestion.strQuestionText sizeWithFont:FONT_Helvetica_15 constrainedToSize:constraintSiz lineBreakMode:UILineBreakModeWordWrap];
    
    [webViewQuestion setFrame:CGRectMake(0, 0, int_view_widih,labelSiz.height+10)];
    [webViewQuestion loadHTMLString:[NSString stringWithFormat: @"<html><body style=\"font-size:15px;font-family:helvetica;\">%@</body></html>",objCurrentQuestion.strQuestionText] baseURL:nil];
    [imgQuestionBG setFrame:CGRectMake(0, labelSiz.height+10, int_view_widih,34)];
    
    tblOptions.scrollEnabled=NO;
    
    if([objCurrentQuestion.arrImagePaths count]==1)
    {
        imageView.hidden=YES;
        pageControl.hidden=YES;
        scorllViewImages.hidden=YES;
        [tblOptions setFrame:CGRectMake(30 ,imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, int_Table_width,int_tbl_hight)];
        [imgTblLast setFrame:CGRectMake(30,tblOptions.frame.origin.y+tblOptions.frame.size.height,int_Table_width,28)];
        [imgTblLast setImage:[UIImage imageNamed:@"Img_View_Option2Bg.png"]];
        
        
    }
    else
    {
        
        
        imageView.hidden=NO;
        pageControl.hidden=NO;
        scorllViewImages.hidden=NO;
        if(int_LPMode==2)
        {
            [tblOptions setFrame:CGRectMake(330 , imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, int_Table_width-297, int_tbl_hight)];
            scorllViewImages=[[UIScrollView alloc]initWithFrame:CGRectMake(55,imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, 265, 195)];
            pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(103, scorllViewImages.frame.origin.y+scorllViewImages.frame.size.height+10,200, 50)];
            [imgTblLast setFrame:CGRectMake(tblOptions.frame.origin.x,tblOptions.frame.origin.y+tblOptions.frame.size.height,tblOptions.frame.size.width,28)];
            [imgTblLast setImage:[UIImage imageNamed:@"Img_View_Option1Bg.png"]];
        }
        else
        {
            scorllViewImages=[[UIScrollView alloc]initWithFrame:CGRectMake(200,imgQuestionBG.frame.origin.y+imgQuestionBG.frame.size.height+int_spaceImgTable, 265, 195)];
            pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(240, scorllViewImages.frame.origin.y+scorllViewImages.frame.size.height+10,200, 50)];
            [tblOptions setFrame:CGRectMake(70 , pageControl.frame.origin.y+pageControl.frame.size.height+10, int_Table_width, int_tbl_hight)];
            [imgTblLast setFrame:CGRectMake(tblOptions.frame.origin.x,tblOptions.frame.origin.y+tblOptions.frame.size.height,int_Table_width,28)];
            [imgTblLast setImage:[UIImage imageNamed:@"Img_View_OptionBg.png"]];
        }
        
        imageView.image=[UIImage imageNamed:[objCurrentQuestion.arrImagePaths objectAtIndex:0]];
        int int_x=0;
        
        for (int int_bulet=0; int_bulet<[objCurrentQuestion.arrImagePaths count]; int_bulet++)
        {
            
            UIImageView *ima_images=[[UIImageView alloc]initWithFrame:CGRectMake(2+int_x, 0, 256, 195)];
            ima_images.Image=[UIImage imageNamed:[objCurrentQuestion.arrImagePaths objectAtIndex:int_bulet]];
            int_x=int_x+265;
            [scorllViewImages addSubview:ima_images];
        }
        
        scorllViewImages.delegate=self;
        scorllViewImages.contentSize=CGSizeMake(265*[objCurrentQuestion.arrImagePaths count], 195);
        scorllViewImages.pagingEnabled=YES;
        
        [pageControl addTarget:self action:@selector(clickPageControl) forControlEvents:UIControlEventTouchUpInside];
        pageControl.numberOfPages=[objCurrentQuestion.arrImagePaths count];
        pageControl.currentPage=0;
        // pageControl.currentPageIndicatorTintColor=COLOR_BLACK;
        // pageControl.pageIndicatorTintColor=COLOR_LIGHTGRAY;
        
    }
}
 */
//-----------------------------------------


#pragma mark - Button Actions
//-----------------------------------------
-(void)clickPageControl
{
    int page=pageControl.currentPage;
    CGRect frame=scorllViewImages.frame;
    frame.origin.x=frame.size.width*page;
    frame.origin.y=0;
    [scorllViewImages scrollRectToVisible:frame animated:YES];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
    }
    
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

    
    char letter = (char) indexPath.row + 65;
    UILabel *lbl_AnsNo=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    lbl_AnsNo.backgroundColor = COLOR_CLEAR;
    lbl_AnsNo.text=[NSString stringWithFormat:@"%c",letter];
    lbl_AnsNo.font = FONT_Helvetica_25;
    lbl_AnsNo.textColor = COLOR_BLUE;
    [cell.contentView addSubview:lbl_AnsNo];


    UIWebView *web_option=[[UIWebView alloc]initWithFrame:CGRectMake(50, 0, width_ - 60, rowHeight)];
    web_option.userInteractionEnabled =NO;
    web_option.backgroundColor = COLOR_BLUE;
    [web_option loadHTMLString:[NSString stringWithFormat: @"<html><body style=\"font-size:17px;font-family:helvetica;\">%@</body></html>",[objCurrentQuestion.arrOptions objectAtIndex:indexPath.row]] baseURL:nil];
    [cell.contentView addSubview:web_option];
    
    if ([strSelectedAnswer isEqualToString:[NSString stringWithFormat:@"%c", letter]])
    {
              [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    char letter = (char) indexPath.row + 65;
    strSelectedAnswer = [NSString stringWithFormat:@"%c",letter];
    SelectedAnswer = [NSString stringWithFormat:@"%c",letter];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    char letter = (char) indexPath.row + 65;
    strSelectedAnswer = [NSString stringWithFormat:@"%c",letter];
    SelectedAnswer = [NSString stringWithFormat:@"%c",letter];    
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
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    currentOrientation = interfaceOrientation;
    [self fnSetUISize];
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
    
}

-(void)fnRotateLandscape
{
    [self.view setFrame:CGRectMake(0,0,1024,644)];
    [imgBG setImage:[UIImage imageNamed:@"Img_Question_texture.png"]];
    [imgBG setFrame:CGRectMake(0,0,1024,644)];
    [imgQuestionBG setImage:[UIImage imageNamed:@"Img_View_QuestionBg.png"]];
}
//---------------------------------------------------------
@end
