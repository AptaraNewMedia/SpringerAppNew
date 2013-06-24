//
//  Questions.h
//  XMLReader
//
//  Created by PUN-MAC-012 on 17/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Questions : NSObject

@property (nonatomic) NSInteger intRowId;
@property (nonatomic) NSInteger intQuestionId;
@property (nonatomic) NSInteger intChapterId;
@property (nonatomic, retain) NSMutableString *strQuestionText;
@property (nonatomic, retain) NSMutableString *strQuestionType;
@property (nonatomic, retain) NSMutableArray *arrOptions;
@property (nonatomic, retain) NSMutableString *strStrokeAnswer;
@property (nonatomic, retain) NSMutableString *strFeedback;
@property (nonatomic, retain) NSMutableArray *arrAnswers;
@property (nonatomic, retain) NSMutableArray *arrImagePaths;

// Extra 
@property (nonatomic) NSInteger intUsed;
@property (nonatomic) NSInteger intBookmark;
@property (nonatomic) NSInteger intAnswered;
@property (nonatomic) NSInteger intNotes;
@property (nonatomic, retain) NSString *strChapterTitle;

@end
