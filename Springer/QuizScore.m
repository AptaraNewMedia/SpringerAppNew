//
//  QuizScore.m
//  Springer1.1
//
//  Created by PUN-MAC-012 on 07/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "QuizScore.h"

@implementation QuizScore

@synthesize intScoreId;
@synthesize strQuizName;
@synthesize intTimer;
@synthesize intRandom;
@synthesize arrQuizIDs;
@synthesize arrQuizVisitedAnswers;
@synthesize arrCorrectIncorrectAnswers;
@synthesize intTotalScore;
@synthesize arrChapterIds;
@synthesize intCurrentQuestion;
@synthesize intBookmarkQuestion;
@synthesize intIncorrectAns;
@synthesize intMissedQuestion;
@synthesize intcorrectAns;
@synthesize arrRationale;

- (id)init {
	if( self = [super init] ) {
        arrQuizIDs = [[NSMutableArray alloc] init];
        arrQuizVisitedAnswers = [[NSMutableArray alloc] init];
        arrCorrectIncorrectAnswers = [[NSMutableArray alloc] init];
        arrChapterIds = [[NSMutableArray alloc] init];
        arrRationale = [[NSMutableArray alloc] init];        
    }
    return self;
}

@end
