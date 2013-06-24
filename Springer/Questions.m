//
//  Questions.m
//  XMLReader
//
//  Created by PUN-MAC-012 on 17/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Questions.h"

@implementation Questions

@synthesize intRowId;
@synthesize intQuestionId;
@synthesize intChapterId;
@synthesize strQuestionText;
@synthesize strQuestionType;
@synthesize arrOptions;
@synthesize strStrokeAnswer;
@synthesize strFeedback;
@synthesize arrAnswers;
@synthesize arrImagePaths;

//Extra
@synthesize intUsed;
@synthesize intBookmark;
@synthesize intAnswered;
@synthesize intNotes;
@synthesize strChapterTitle;


- (id)init {
	if( self = [super init] ) {            
        strQuestionText = [[NSMutableString alloc] init];
        strQuestionType = [[NSMutableString alloc] init];
        strStrokeAnswer = [[NSMutableString alloc] init];
        strFeedback = [[NSMutableString alloc] init];
        
        arrOptions = [[NSMutableArray alloc] init];
        arrAnswers = [[NSMutableArray alloc] init];
        arrImagePaths = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
