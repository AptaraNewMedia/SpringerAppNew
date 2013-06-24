//
//  QuizScore.h
//  Springer1.1
//
//  Created by PUN-MAC-012 on 07/02/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuizScore : NSObject

@property (nonatomic) NSInteger intScoreId;
@property (nonatomic, retain) NSString *strQuizName;
@property (nonatomic) NSInteger intTimer;
@property (nonatomic) NSInteger intRandom;
@property (nonatomic, retain) NSMutableArray *arrQuizIDs;
@property (nonatomic, retain) NSMutableArray *arrQuizVisitedAnswers;
@property (nonatomic, retain) NSMutableArray *arrCorrectIncorrectAnswers;
@property (nonatomic) NSInteger intTotalScore;
@property (nonatomic, retain) NSMutableArray *arrChapterIds;
@property (nonatomic) NSInteger intCurrentQuestion;
@property (nonatomic) NSInteger intBookmarkQuestion;
@property (nonatomic) NSInteger intIncorrectAns;
@property (nonatomic) NSInteger intMissedQuestion;
@property (nonatomic) NSInteger intcorrectAns;
@property (nonatomic, retain) NSMutableArray *arrRationale;
@end
