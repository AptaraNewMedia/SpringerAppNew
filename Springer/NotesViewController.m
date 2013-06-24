//
//  NotesViewController.m
//  Springer
//
//  Created by systems pune on 09/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "NotesViewController.h"
#import "Notes.h"
@interface NotesViewController()
{
    IBOutlet UIButton *Bn_Close;
    IBOutlet UIButton *Bn_Clear;
    IBOutlet UITextView *txtNote;
    IBOutlet UIImageView *img_bg;
    IBOutlet UIView *view_Note;
    IBOutlet UILabel *lbl_Note;
    IBOutlet UIButton *Bn_save;
    IBOutlet UIScrollView *scroll;
    IBOutlet UIView *view_NoteView;
    int flag;
    
    Notes *objNotes;    
    float text_contentSize;
}


-(IBAction)Bn_closeTapped:(id)sender;
-(IBAction)OnSave:(id)sender;
-(IBAction)Bn_ClearTapped:(id)sender;

@end

@implementation NotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSLog(@"Description %@",md.str_Desc);
//    txtNote.text = md.str_Desc;
    for (int i=20; i<txtNote.frame.size.height; i=i+18) {
          UIImageView *imgline=[[UIImageView alloc]initWithFrame:CGRectMake(1, i+2, 559, 1)];
        [imgline setImage: [UIImage imageNamed:@"ImageNoteLine"]];
        [txtNote addSubview:imgline];
        [txtNote sendSubviewToBack:imgline];
       
    }
    txtNote.contentSize=CGSizeMake(txtNote.frame.size.width, txtNote.frame.size.height);
     text_contentSize=txtNote.contentSize.height;
    txtNote.delegate=self;
    [self fnSetFontColor];
    
    
    txtNote.text = objNotes.strnote_desc;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


///
-(IBAction)Bn_closeTapped:(id)sender
{
    [self textViewShouldEndEditing:txtNote];
    [md Fn_SubNote];

}

-(IBAction)Bn_ClearTapped:(id)sender
{
   txtNote.text=@"";
    
}


-(void)fnSetFontColor
{
    //Color
 
    self.view.backgroundColor = COLOR_BG_BLACK_04;

    lbl_Note.textColor = COLOR_TEXT_WHITE;
    lbl_Note.font = FONT_Helvetica_Roman_20;
    lbl_Note.shadowColor =  [UIColor blackColor];
    lbl_Note.shadowOffset = CGSizeMake(0, 1.0);
    
    Bn_Close.titleLabel.textColor=COLOR_TEXT_WHITE;
    Bn_Close.titleLabel.font=FONT_Helvetica_bold_12;
    Bn_Close.titleLabel.shadowColor = [UIColor blackColor];
    Bn_Close.titleLabel.shadowOffset = CGSizeMake(0, -1.0);
    
    Bn_Clear.titleLabel.textColor=COLOR_TEXT_WHITE;
    Bn_Clear.titleLabel.font=FONT_Helvetica_bold_12;
    Bn_Clear.titleLabel.shadowColor = [UIColor blackColor];
    Bn_Clear.titleLabel.shadowOffset = CGSizeMake(0, -1.0);
    
    Bn_save.titleLabel.shadowColor = [UIColor blackColor];
    Bn_save.titleLabel.shadowOffset = CGSizeMake(0, -1.0);
    Bn_save.titleLabel.textColor=COLOR_TEXT_WHITE;
    Bn_save.titleLabel.font=FONT_Helvetica_bold_12;
    txtNote.font = FONT_Trebuchet_MS_14;
    txtNote.textColor = COLOR_BLACK_Rgb;

}

-(void)fnSetData:(Notes *)notes
{
    objNotes = notes;
}

//
-(IBAction)OnSave:(id)sender
{
    objNotes.strnote_desc = txtNote.text;
    if (objNotes.strnote_desc.length > 0) {
        objNotes.intnote_id = 1;
    }
    else {
        objNotes.intnote_id = 0;
    }
    
    if (objNotes.intmode == 1) {
        //[db fnSetNote:objNotes];
        [db fnUpdateNote:objNotes];
    }
    else {
        [db fnUpdateNote:objNotes];
    }
    
    [md Fn_SubNote];
    
    if (objNotes.strnote_desc.length > 0) {
        [md Fn_SetNoteIcons:YES];
    }
    else {
        [md Fn_SetNoteIcons:NO];
    }
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (txtNote.contentSize.height>text_contentSize)
    {
        UIImageView *imgline=[[UIImageView alloc]initWithFrame:CGRectMake(1, txtNote.contentSize.height+6, 559, 1)];
        [imgline setImage: [UIImage imageNamed:@"ImageNoteLine"]];
        [txtNote addSubview:imgline];
        text_contentSize=txtNote.contentSize.height;
        [txtNote sendSubviewToBack:imgline];
//            NSLog(@"%fsssss",txtNote.contentSize.height);
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
      [txtNote setFrame:CGRectMake(0, 85, 561, 465)];
    flag=0;
       return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[UIApplication sharedApplication].statusBarOrientation;
    if (interfaceOrientation==3||interfaceOrientation==4)
    {
        [txtNote setFrame:CGRectMake(0, 85, 561, 233)];
    }
    else
    {
        [txtNote setFrame:CGRectMake(0, 85, 561, 443)];
        
    }
    flag=1;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
     
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark - Rotations
//-----------------------------------------


-(void)fn_Portrait
{
    [self.view setFrame:CGRectMake(0, -44, 768, 1024)];
    [view_Note setFrame:CGRectMake(103.5, 227.5, 561, 569)];
    if (flag==1) {
        [txtNote setFrame:CGRectMake(0, 85, 561, 443)];

    }
   
   

}
-(void)fn_Landscape
{
    [self.view setFrame:CGRectMake(0, -44, 1024, 768)];
    [view_Note setFrame:CGRectMake(231.5, 99.5, 561, 569)];
    if (flag==1) {
        [txtNote setFrame:CGRectMake(0, 85, 561, 233)];
        
    }

}



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

//---------------------------------------------------------
@end
