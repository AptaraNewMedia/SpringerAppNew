//
//  DatabaseOperation.h
//  Springer1.1
//
//  Created by PUN-MAC-012 on 31/01/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <Foundation/Foundation.h>


@class QuizScore;
@class Notes;
@class Favourites;

@interface DatabaseQueries : NSObject


//
- (void) fnSetChapterQuestionData:(NSMutableArray *)data;

//
-(int) fnCheckXMLCopiedInDatabase;
-(void) fnUPdateXMLexistinDatabase;

//
-(void) fnGetChapterList;

//
-(NSMutableArray *) fnGetQuestionListByChapter:(NSMutableArray *)arrchapter;
-(void) fnGetQuestionList:(NSMutableArray *)arrchapter withUsed:(int)used withunUsed:(int)unused withBookmark:(int)bookmark withAnswered:(int)answered withNotes:(int)notes;

//
-(int) fnCheckQuizNameExist:(NSString *)quizname;
-(int) fnGetCountOFQuizScoreId;
-(void) fnGetQuizScoreData;
-(NSMutableArray *) fnGetQuizScoreByChapter:(int)chapter_id;
-(NSMutableArray *) fnGetQuizScoreOfAllChapter;
-(QuizScore *) fnGetQuizScoreObjectByQuizScoreId:(int)scoreId;
-(void) fnSetQuizScoreData :(QuizScore *)quizscore;
-(void) fnUpdateQuizScoreData :(QuizScore *)quizscore;
-(void) fnUpdateQuizScoreDataOnSubmit :(QuizScore *)quizscore;
-(void)fnDeleteScore:(int)score_id;
-(void)fnDeleteAllScore;

//
-(void) fnSetNote:(Notes *)notes;
-(void) fnUpdateNote:(Notes *)notes;
-(Notes *) fnGetNote:(int)question_id AndChapterID:(int)chapter_id  AndQuizScoreId:(int)score_id;

//
-(void) fnSetFavourite:(Favourites *)favourites;
-(void)fnDeleteFavourite:(Favourites *)favourites;
-(Favourites *) fnCheckFavourites:(int)question_id AndChapterID:(int)chapter_id  AndQuizScoreId:(int)score_id;


@end
