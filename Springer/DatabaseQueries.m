//
//  DatabaseOperation.m
//  Springer1.1
//
//  Created by PUN-MAC-012 on 31/01/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "DatabaseQueries.h"
#import "SQLiteManager.h"

#import "Chapters.h"
#import "Questions.h"
#import "QuizScore.h"
#import "Notes.h"
#import "Favourites.h"

@interface DatabaseQueries () {
    //
    SQLiteManager *sqlManager;
    Chapters *objChap;
    Questions *objQues;
    QuizScore *objQuizScore;
    //
    
    //
    NSString *strQuery;
    NSArray *arrTempList;
    int intRowCount;
    NSError *error;
    //
}
@end


@implementation DatabaseQueries

-(id) init {
    self = [super init];
    
	if(self != nil) {
        sqlManager = [[SQLiteManager alloc] init];
        [sqlManager createDatabaseInApplicationDirectory];
	}
	return self;
}


//--------------------------------------------------------------
#pragma mark -
#pragma mark Menu FNS
//--------------------------------------------------------------
-(void) fnSetChapterQuestionData:(NSMutableArray *)data
{
    intRowCount = [data count];
    int intQueCount;
    for (int i=0; i<intRowCount; i++) {
        objChap = (Chapters *)[data objectAtIndex:i];
        intQueCount = [objChap.arrQuestionSet count];
        
        strQuery = [NSString stringWithFormat:@"select chapter_id from chapters where chapter_id = %d;", objChap.intChapterId];
        arrTempList = [sqlManager getRowsForQuery:strQuery];
        if ([arrTempList count] == 0)
            strQuery = [NSString stringWithFormat:@"insert into chapters (chapter_id, 'chapter_name', question_count) values(%d,'%@', %d);", objChap.intChapterId, objChap.strChapterTitle, intQueCount];
        
        else
            strQuery = [NSString stringWithFormat:@"update chapters set chapter_name = '%@', question_count = %d where chapter_id = %d;",  objChap.strChapterTitle,intQueCount, objChap.intChapterId];
        
        error = [sqlManager doQuery:strQuery];
        if (error != nil) {
            NSLog(@"Error: %@",[error localizedDescription]);
        }
        
        for (int j=0; j<intQueCount; j++) {
            
            objQues = (Questions *)[objChap.arrQuestionSet objectAtIndex:j];
            
            strQuery = [NSString stringWithFormat:@"select question_id from questions where chapter_id = %d and question_id = %d;", objChap.intChapterId, objQues.intQuestionId];
            arrTempList = [sqlManager getRowsForQuery:strQuery];
            if ([arrTempList count] == 0)
                strQuery = [NSString stringWithFormat:@"insert into questions (chapter_id,question_id, question_type, question_text, options, strokeanswer, rationaletext, answers, image_paths) values(%d,%d,'%@','%@','%@','%@',\"%@\",'%@','%@');", objChap.intChapterId, objQues.intQuestionId, objQues.strQuestionType, objQues.strQuestionText, [objQues.arrOptions componentsJoinedByString:DELIMITER_ARR],objQues.strStrokeAnswer, objQues.strFeedback, [objQues.arrAnswers componentsJoinedByString:DELIMITER_ARR], [objQues.arrImagePaths componentsJoinedByString:DELIMITER_ARR]];
            
            else
                strQuery = [NSString stringWithFormat:@"update questions set question_type = '%@', question_text = '%@', options = '%@', strokeanswer = '%@', rationaletext = '%@', answers = '%@', image_paths = '%@' where  chapter_id = %d and question_id = %d;", objQues.strQuestionType, objQues.strQuestionText, [objQues.arrOptions componentsJoinedByString:DELIMITER_ARR],objQues.strStrokeAnswer, objQues.strFeedback, [objQues.arrAnswers componentsJoinedByString:DELIMITER_ARR], [objQues.arrImagePaths componentsJoinedByString:DELIMITER_ARR],objChap.intChapterId, objQues.intQuestionId];
            
            error = [sqlManager doQuery:strQuery];
            if (error != nil) {
                NSLog(@"Error: %@",[error localizedDescription]);
            }
        }
        
        
        
    }
    
}
//--------------------------------------------------------------


//--------------------------------------------------------------
#pragma mark -
#pragma mark XML
//--------------------------------------------------------------
-(int) fnCheckXMLCopiedInDatabase
{
    strQuery = [NSString stringWithFormat:@"SELECT exist FROM xml"];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];    
    int val = 0;
    for (int i = 0; i < intRowCount; i++) {
        val =  [[[arrTempList objectAtIndex:i] objectForKey:@"exist"] intValue];
    }
    if (val == 1) {
        return 1;
    }
    return 0;
}

-(void) fnUPdateXMLexistinDatabase {
    strQuery = [NSString stringWithFormat:@"UPDATE xml SET exist = 1, created_date = %@", CURRENT_DATE];
    error = [sqlManager doQuery:strQuery];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }

}

//--------------------------------------------------------------

//--------------------------------------------------------------
#pragma mark -
#pragma mark Chapters
//--------------------------------------------------------------
-(void) fnGetChapterList
{    
    chapterDbData = [[NSMutableArray alloc] init];
    strQuery = [NSString stringWithFormat:@"select chapter_name, chapter_id, question_count from chapters order by chapter_name"];
    //strQuery = [NSString stringWithFormat:@"select chapter_name, chapter_id, question_count from chapters"];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];
    for (int i = 0; i < intRowCount; i++) {
        objChap = [Chapters new];
        objChap.intChapterId = [[[arrTempList objectAtIndex:i] objectForKey:@"chapter_id"] intValue];
        objChap.strChapterTitle = [[arrTempList objectAtIndex:i] objectForKey:@"chapter_name"];
        objChap.intQuestionCount = [[[arrTempList objectAtIndex:i] objectForKey:@"question_count"] intValue];
        [chapterDbData addObject:objChap];
    }
}
//--------------------------------------------------------------

//--------------------------------------------------------------
#pragma mark -
#pragma mark Questions
//--------------------------------------------------------------

-(NSMutableArray *) fnGetQuestionListByChapter:(NSMutableArray *)arrchapter
{
    NSMutableArray *quesDbData = [[NSMutableArray alloc] init];
    
    strQuery = [NSString stringWithFormat:@"SELECT q.rowid, q.question_id, q.chapter_id, q.question_type, q.question_text, q.options, q.strokeanswer, q.rationaletext, q.answers, q.image_paths, q.status, q.bookmark, q.answered, q.notes, c.chapter_name FROM questions as q, chapters as c WHERE q.chapter_id = c.chapter_id AND q.chapter_id IN %@ ORDER BY q.chapter_id, q.question_id", arrchapter];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];
    for (int i = 0; i < intRowCount; i++) {
        objQues = [Questions new];
        objQues.intRowId = [[[arrTempList objectAtIndex:i] objectForKey:@"rowid"] intValue];
        objQues.intQuestionId = [[[arrTempList objectAtIndex:i] objectForKey:@"question_id"] intValue];
        objQues.intChapterId = [[[arrTempList objectAtIndex:i] objectForKey:@"chapter_id"] intValue];
        objQues.strQuestionType = [[arrTempList objectAtIndex:i] objectForKey:@"question_type"] ;
        objQues.strQuestionText = [[arrTempList objectAtIndex:i] objectForKey:@"question_text"] ;
        NSArray *options= [[[arrTempList objectAtIndex:i] objectForKey:@"options"]  componentsSeparatedByString:DELIMITER_ARR];
        objQues.arrOptions = [options copy];
        objQues.strStrokeAnswer = [[arrTempList objectAtIndex:i] objectForKey:@"strokeanswer"] ;
        objQues.strFeedback = [[arrTempList objectAtIndex:i] objectForKey:@"rationaletext"] ;
        NSArray *answers= [[[arrTempList objectAtIndex:i] objectForKey:@"answers"] componentsSeparatedByString:DELIMITER_ARR];
        objQues.arrAnswers = [answers copy];
        NSArray *imagepaths = [[[arrTempList objectAtIndex:i] objectForKey:@"image_paths"] componentsSeparatedByString:DELIMITER_ARR];
        if ([imagepaths count]>=1 &&![[imagepaths objectAtIndex:0]isEqualToString:@""]) {
            objQues.arrImagePaths = [imagepaths copy];
            
        }
        objQues.strChapterTitle = [[arrTempList objectAtIndex:i] objectForKey:@"chapter_name"];
        objQues.intUsed = [[[arrTempList objectAtIndex:i] objectForKey:@"status"] intValue];
        objQues.intBookmark = [[[arrTempList objectAtIndex:i] objectForKey:@"bookmark"] intValue];
        objQues.intAnswered = [[[arrTempList objectAtIndex:i] objectForKey:@"answered"] intValue];
        objQues.intNotes = [[[arrTempList objectAtIndex:i] objectForKey:@"notes"] intValue];
        
        [quesDbData addObject:objQues];
    }
    
    return quesDbData;
}

-(void) fnGetQuestionList:(NSMutableArray *)arrchapter withUsed:(int)used withunUsed:(int)unused withBookmark:(int)bookmark withAnswered:(int)answered withNotes:(int)notes
{
    questionsDbData = [[NSMutableArray alloc] init];
    
    NSMutableString *search = [[NSMutableString alloc] init];
    
    if (used!= -1 && unused!= -1) {
        [search appendFormat:@" status != -1 OR"];
    }
    else if (used!= -1) {
        [search appendFormat:@" status = %d OR", used];
    }
    else if (unused!= -1) {
        [search appendFormat:@" status = %d OR", unused];
    }
    if (bookmark!= 0) {
        [search appendFormat:@" bookmark = %d OR", bookmark];
    }
    if (answered!= -1) {
        [search appendFormat:@" answered = %d OR", answered];
    }
    if (notes!= 0) {
        [search appendFormat:@" notes = %d OR", notes];
    }
    
    if (search.length > 0) {
        strQuery = [NSString stringWithFormat:@"SELECT q.rowid, q.question_id, q.chapter_id, q.question_type, q.question_text, q.options, q.strokeanswer, q.rationaletext, q.answers, q.image_paths, q.status, q.bookmark, q.answered, c.chapter_name FROM questions as q, chapters as c WHERE q.chapter_id = c.chapter_id AND q.chapter_id IN %@ AND (%@)  GROUP BY question_id ORDER BY random()", arrchapter, [search substringToIndex:[search length] - 2]];
    }
    else {
        strQuery = [NSString stringWithFormat:@"SELECT q.rowid, q.question_id, q.chapter_id, q.question_type, q.question_text, q.options, q.strokeanswer, q.rationaletext, q.answers, q.image_paths, q.status, q.bookmark, q.answered, c.chapter_name FROM questions as q, chapters as c WHERE q.chapter_id = c.chapter_id AND q.chapter_id IN %@  GROUP BY question_id ORDER BY random()", arrchapter];
    }
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];
    //NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i = 0; i < intRowCount; i++) {
        objQues = [Questions new];
        objQues.intRowId = [[[arrTempList objectAtIndex:i] objectForKey:@"rowid"] intValue];
        objQues.intQuestionId = [[[arrTempList objectAtIndex:i] objectForKey:@"question_id"] intValue];
        objQues.intChapterId = [[[arrTempList objectAtIndex:i] objectForKey:@"chapter_id"] intValue];
        objQues.strQuestionType = [[arrTempList objectAtIndex:i] objectForKey:@"question_type"] ;
        objQues.strQuestionText = [[arrTempList objectAtIndex:i] objectForKey:@"question_text"] ;
        NSArray *options= [[[arrTempList objectAtIndex:i] objectForKey:@"options"]  componentsSeparatedByString:DELIMITER_ARR];
        objQues.arrOptions = [options copy];
        objQues.strStrokeAnswer = [[arrTempList objectAtIndex:i] objectForKey:@"strokeanswer"] ;
        objQues.strFeedback = [[arrTempList objectAtIndex:i] objectForKey:@"rationaletext"] ;
        NSArray *answers= [[[arrTempList objectAtIndex:i] objectForKey:@"answers"] componentsSeparatedByString:DELIMITER_ARR];
        objQues.arrAnswers = [answers copy];
        NSArray *imagepaths = [[[arrTempList objectAtIndex:i] objectForKey:@"image_paths"] componentsSeparatedByString:DELIMITER_ARR];
        if ([imagepaths count]>=1 &&![[imagepaths objectAtIndex:0]isEqualToString:@""]) {
            objQues.arrImagePaths = [imagepaths copy];
            
        }
        objQues.strChapterTitle = [[arrTempList objectAtIndex:i] objectForKey:@"chapter_name"];
        objQues.intUsed = [[[arrTempList objectAtIndex:i] objectForKey:@"status"] intValue];
        objQues.intBookmark = [[[arrTempList objectAtIndex:i] objectForKey:@"bookmark"] intValue];
        objQues.intAnswered = [[[arrTempList objectAtIndex:i] objectForKey:@"answered"] intValue];
        
        [questionsDbData addObject:objQues];
    }
}

//--------------------------------------------------------------
//--------------------------------------------------------------

//--------------------------------------------------------------
#pragma mark -
#pragma mark Quiz Score
//--------------------------------------------------------------
-(int) fnCheckQuizNameExist:(NSString *)quizname
{
    strQuery = [NSString stringWithFormat:@"select quiz_name from quiz_score where quiz_name = %@;", quizname];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    if ([arrTempList count] != 0)
        return 1;
    return 0;
}

-(int) fnGetCountOFQuizScoreId
{
    strQuery = [NSString stringWithFormat:@"select count(score_id) from quiz_score"];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];
    for (int i = 0; i < intRowCount; i++) {
        return [[[arrTempList objectAtIndex:i] objectForKey:@"count(score_id)"] intValue];
    }
    return 0;
}

-(void) fnGetQuizScoreData
{
    quizscoreDbData = [[NSMutableArray alloc] init];
    strQuery = [NSString stringWithFormat:@"SELECT score_id, quiz_ids, quiz_name, timer, random, visited_answers, score, ch_ids, current_question, bookmark_question, incorrect_ans, missed_que, correct_ans, correct_Incorrect FROM quiz_score WHERE completed = 1"];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];
    for (int i = 0; i < intRowCount; i++) {
        objQuizScore = [QuizScore new];
        objQuizScore.intScoreId = [[[arrTempList objectAtIndex:i] objectForKey:@"score_id"] intValue];
        NSArray *quizIds= [[[arrTempList objectAtIndex:i] objectForKey:@"quiz_ids"]  componentsSeparatedByString:@","];
        objQuizScore.arrQuizIDs = [quizIds copy];
        objQuizScore.strQuizName = [[arrTempList objectAtIndex:i] objectForKey:@"quiz_name"];
        objQuizScore.intTimer = [[[arrTempList objectAtIndex:i] objectForKey:@"timer"] intValue];
        objQuizScore.intRandom = [[[arrTempList objectAtIndex:i] objectForKey:@"random"] intValue];
        NSArray *visited= [[[arrTempList objectAtIndex:i] objectForKey:@"visited_answers"]  componentsSeparatedByString:@","];
        objQuizScore.arrQuizVisitedAnswers = [NSMutableArray arrayWithArray:visited];
        objQuizScore.intTotalScore = [[[arrTempList objectAtIndex:i] objectForKey:@"score"] intValue] ;
        NSArray *chIds= [[[arrTempList objectAtIndex:i] objectForKey:@"ch_ids"]  componentsSeparatedByString:@","];
        objQuizScore.arrChapterIds = [chIds copy];
        
        objQuizScore.intCurrentQuestion = [[[arrTempList objectAtIndex:i] objectForKey:@"current_question"] intValue];
        objQuizScore.intBookmarkQuestion = [[[arrTempList objectAtIndex:i] objectForKey:@"bookmark_question"] intValue];
        objQuizScore.intIncorrectAns = [[[arrTempList objectAtIndex:i] objectForKey:@"incorrect_ans"] intValue];
        objQuizScore.intMissedQuestion = [[[arrTempList objectAtIndex:i] objectForKey:@"missed_que"] intValue];
        objQuizScore.intcorrectAns = [[[arrTempList objectAtIndex:i] objectForKey:@"correct_ans"] intValue];
        NSArray *correct_Incorrect= [[[arrTempList objectAtIndex:i] objectForKey:@"correct_Incorrect"]  componentsSeparatedByString:@","];
        objQuizScore.arrCorrectIncorrectAnswers = [NSMutableArray arrayWithArray:correct_Incorrect];
        
        [quizscoreDbData addObject:objQuizScore];
    }
    
}

-(NSMutableArray *) fnGetQuizScoreByChapter:(int)chapter_id
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    strQuery = [NSString stringWithFormat:@"SELECT q.rowid, q.question_id, q.chapter_id, q.question_type, q.question_text, q.options, q.strokeanswer, q.rationaletext, q.answers, q.image_paths, q.status, q.bookmark, q.answered, c.chapter_name FROM questions as q, chapters as c WHERE q.chapter_id = c.chapter_id AND q.chapter_id = %d ORDER BY q.chapter_id, q.question_id", chapter_id];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];
    for (int i = 0; i < intRowCount; i++) {
        objQues = [Questions new];
        objQues.intRowId = [[[arrTempList objectAtIndex:i] objectForKey:@"rowid"] intValue];
        objQues.intQuestionId = [[[arrTempList objectAtIndex:i] objectForKey:@"question_id"] intValue];
        objQues.intChapterId = [[[arrTempList objectAtIndex:i] objectForKey:@"chapter_id"] intValue];
        objQues.strQuestionType = [[arrTempList objectAtIndex:i] objectForKey:@"question_type"] ;
        objQues.strQuestionText = [[arrTempList objectAtIndex:i] objectForKey:@"question_text"] ;
        NSArray *options= [[[arrTempList objectAtIndex:i] objectForKey:@"options"]  componentsSeparatedByString:DELIMITER_ARR];
        objQues.arrOptions = [options copy];
        objQues.strStrokeAnswer = [[arrTempList objectAtIndex:i] objectForKey:@"strokeanswer"] ;
        objQues.strFeedback = [[arrTempList objectAtIndex:i] objectForKey:@"rationaletext"] ;
        NSArray *answers= [[[arrTempList objectAtIndex:i] objectForKey:@"answers"] componentsSeparatedByString:DELIMITER_ARR];
        objQues.arrAnswers = [answers copy];
        NSArray *imagepaths = [[[arrTempList objectAtIndex:i] objectForKey:@"image_paths"] componentsSeparatedByString:DELIMITER_ARR];
        if ([imagepaths count]>=1 &&![[imagepaths objectAtIndex:0]isEqualToString:@""]) {
            objQues.arrImagePaths = [imagepaths copy];
        }
        objQues.strChapterTitle = [[arrTempList objectAtIndex:i] objectForKey:@"chapter_name"];
        objQues.intUsed = [[[arrTempList objectAtIndex:i] objectForKey:@"status"] intValue];
        objQues.intBookmark = [[[arrTempList objectAtIndex:i] objectForKey:@"bookmark"] intValue];
        objQues.intAnswered = [[[arrTempList objectAtIndex:i] objectForKey:@"answered"] intValue];
        
        [temp addObject:objQues];
    }
    return temp;
}

-(NSMutableArray *) fnGetQuizScoreOfAllChapter
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    strQuery = [NSString stringWithFormat:@"SELECT q.rowid, q.question_id, q.chapter_id, q.question_type, q.question_text, q.options, q.strokeanswer, q.rationaletext, q.answers, q.image_paths, q.status, q.bookmark, q.answered, c.chapter_name FROM questions as q, chapters as c WHERE q.chapter_id = c.chapter_id ORDER BY q.chapter_id, q.question_id"];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];
    for (int i = 0; i < intRowCount; i++) {
        objQues = [Questions new];
        objQues.intRowId = [[[arrTempList objectAtIndex:i] objectForKey:@"rowid"] intValue];
        objQues.intUsed = [[[arrTempList objectAtIndex:i] objectForKey:@"status"] intValue];
        objQues.intBookmark = [[[arrTempList objectAtIndex:i] objectForKey:@"bookmark"] intValue];
        objQues.intAnswered = [[[arrTempList objectAtIndex:i] objectForKey:@"answered"] intValue];
        
        [temp addObject:objQues];
    }
    return temp;
}

-(QuizScore *) fnGetQuizScoreObjectByQuizScoreId:(int)scoreId
{
    strQuery = [NSString stringWithFormat:@"SELECT score_id, quiz_ids, quiz_name, timer, random, visited_answers, score, ch_ids, current_question, bookmark_question, incorrect_ans, missed_que, correct_ans, correct_Incorrect FROM quiz_score WHERE score_id = %d", scoreId];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];
    for (int i = 0; i < intRowCount; i++) {
        objQuizScore = [QuizScore new];
        objQuizScore.intScoreId = [[[arrTempList objectAtIndex:i] objectForKey:@"score_id"] intValue];
        NSArray *quizIds= [[[arrTempList objectAtIndex:i] objectForKey:@"quiz_ids"]  componentsSeparatedByString:@","];
        objQuizScore.arrQuizIDs = [quizIds copy];
        objQuizScore.strQuizName = [[arrTempList objectAtIndex:i] objectForKey:@"quiz_name"];
        objQuizScore.intTimer = [[[arrTempList objectAtIndex:i] objectForKey:@"timer"] intValue];
        objQuizScore.intRandom = [[[arrTempList objectAtIndex:i] objectForKey:@"random"] intValue];
        NSArray *visited= [[[arrTempList objectAtIndex:i] objectForKey:@"visited_answers"]  componentsSeparatedByString:@","];
        objQuizScore.arrQuizVisitedAnswers = [NSMutableArray arrayWithArray:visited];
        objQuizScore.intTotalScore = [[[arrTempList objectAtIndex:i] objectForKey:@"score"] intValue] ;
        NSArray *chIds= [[[arrTempList objectAtIndex:i] objectForKey:@"ch_ids"]  componentsSeparatedByString:@","];
        objQuizScore.arrChapterIds = [chIds copy];
        
        objQuizScore.intCurrentQuestion = [[[arrTempList objectAtIndex:i] objectForKey:@"current_question"] intValue];
        objQuizScore.intBookmarkQuestion = [[[arrTempList objectAtIndex:i] objectForKey:@"bookmark_question"] intValue];
        objQuizScore.intIncorrectAns = [[[arrTempList objectAtIndex:i] objectForKey:@"incorrect_ans"] intValue];
        objQuizScore.intMissedQuestion = [[[arrTempList objectAtIndex:i] objectForKey:@"missed_que"] intValue];
        objQuizScore.intcorrectAns = [[[arrTempList objectAtIndex:i] objectForKey:@"correct_ans"] intValue];
        NSArray *correct_Incorrect= [[[arrTempList objectAtIndex:i] objectForKey:@"correct_Incorrect"]  componentsSeparatedByString:@","];
        objQuizScore.arrCorrectIncorrectAnswers = [NSMutableArray arrayWithArray:correct_Incorrect];
        
    }
    return objQuizScore;
}

-(void) fnSetQuizScoreData :(QuizScore *)quizscore
{
    objQuizScore = (QuizScore *)quizscore;
    
    strQuery = [NSString stringWithFormat:@"insert into quiz_score (score_id, quiz_ids, quiz_name, timer, random, visited_answers, score, ch_ids, current_question, incorrect_ans,missed_que,correct_ans,correct_Incorrect) values(%d,'%@', '%@',%d, %d, '%@', %d,'%@', %d, %d, %d,%d,'%@');", objQuizScore.intScoreId, [objQuizScore.arrQuizIDs componentsJoinedByString:@","], objQuizScore.strQuizName, objQuizScore.intTimer, objQuizScore.intRandom, [objQuizScore.arrQuizVisitedAnswers componentsJoinedByString:@","],objQuizScore.intTotalScore, [objQuizScore.arrChapterIds componentsJoinedByString:@","], objQuizScore.intCurrentQuestion, objQuizScore.intIncorrectAns, objQuizScore.intMissedQuestion,objQuizScore.intcorrectAns,[objQuizScore.arrCorrectIncorrectAnswers componentsJoinedByString:@","]];
    
    error = [sqlManager doQuery:strQuery];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
}

-(void) fnUpdateQuizScoreData :(QuizScore *)quizscore
{
    QuizScore *score = (QuizScore *)quizscore;
    
    strQuery = [NSString stringWithFormat:@"UPDATE quiz_score SET timer = %d, random =%d, visited_answers = '%@', score = %d, current_question = %d, bookmark_question = %d, incorrect_ans = %d, missed_que = %d,correct_ans= %d, correct_Incorrect= '%@', completed = 1 WHERE score_id = %d",  score.intTimer, score.intRandom, [score.arrQuizVisitedAnswers componentsJoinedByString:@","],score.intTotalScore, score.intCurrentQuestion, score.intBookmarkQuestion, score.intIncorrectAns, score.intMissedQuestion,score.intcorrectAns,[score.arrCorrectIncorrectAnswers componentsJoinedByString:@","], score.intScoreId];
    
    error = [sqlManager doQuery:strQuery];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
    
    for (int i = 0; i < score.arrQuizIDs.count; i++) {
        
        NSString *temp = [score.arrQuizVisitedAnswers objectAtIndex:i];
        int status = 1;
        int answered = [[score.arrCorrectIncorrectAnswers objectAtIndex:i] intValue];
        if ([temp isEqualToString:@"NA"]) {
            status = 0;
            answered = -1;
        }
        else {
            strQuery = [NSString stringWithFormat:@"UPDATE questions SET status = %d, answered = %d  WHERE question_id = %d", status, answered, [[score.arrQuizIDs objectAtIndex:i] intValue] ];
            error = [sqlManager doQuery:strQuery];
            if (error != nil) {
                NSLog(@"Error: %@",[error localizedDescription]);
            }
        }
    }
    
}

-(void) fnUpdateQuizScoreDataOnSubmit :(QuizScore *)quizscore
{
    QuizScore *score = (QuizScore *)quizscore;
    
    strQuery = [NSString stringWithFormat:@"UPDATE quiz_score SET visited_answers = '%@',current_question = %d,correct_Incorrect= '%@' WHERE score_id = %d",[score.arrQuizVisitedAnswers componentsJoinedByString:@","],score.intCurrentQuestion,[score.arrCorrectIncorrectAnswers componentsJoinedByString:@","], score.intScoreId];
    
    error = [sqlManager doQuery:strQuery];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
}

-(void)fnDeleteScore:(int)score_id
{
    strQuery = [NSString stringWithFormat:@"DELETE FROM quiz_score WHERE score_id = %d ", score_id];
    error = [sqlManager doQuery:strQuery];
	if (error != nil) {
		NSLog(@"Error: %@",[error localizedDescription]);
	}
    
}

-(void)fnDeleteAllScore
{
    strQuery = [NSString stringWithFormat:@"UPDATE questions SET status = 0, answered = -1"];
    error = [sqlManager doQuery:strQuery];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
    
    strQuery = [NSString stringWithFormat:@"DELETE from quiz_score"];
    error = [sqlManager doQuery:strQuery];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
    
}
//--------------------------------------------------------------


//--------------------------------------------------------------
#pragma mark -
#pragma mark Notes
//--------------------------------------------------------------
-(void) fnSetNote:(Notes *)notes {
    strQuery = [NSString stringWithFormat:@"INSERT INTO notes (note_desc, question_id, chapter_id, score_id, modified_date, created_date) VALUES ('%@', %d, %d, %d,  '%@', '%@')", notes.strnote_desc, notes.intquestion_id, notes.intchapter_id, notes.intscore_id, notes.strmodified_date, notes.strcreated_date];
    error = [sqlManager doQuery:strQuery];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
}
-(void) fnUpdateNote:(Notes *)notes {
    strQuery = [NSString stringWithFormat:@"UPDATE questions SET note_desc = '%@', notes = %d WHERE question_id = %d ", notes.strnote_desc, notes.intnote_id, notes.intquestion_id];
    error = [sqlManager doQuery:strQuery];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
}
-(Notes *) fnGetNote:(int)question_id AndChapterID:(int)chapter_id  AndQuizScoreId:(int)score_id {    
    
    Notes *objNote = [[Notes alloc] init];
    strQuery = [NSString stringWithFormat:@"SELECT notes, note_desc FROM questions WHERE question_id = %d",question_id];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];
    for (int i = 0; i < intRowCount; i++) {
        objNote.intnote_id  =   [[[arrTempList objectAtIndex:i] objectForKey:@"notes"] intValue];
        objNote.strnote_desc = [[arrTempList objectAtIndex:i] objectForKey:@"note_desc"];
        if (objNote.strnote_desc == (id)[NSNull null] || objNote.strnote_desc.length == 0 )
            objNote.strnote_desc = @"";        
    }
    if (intRowCount == 0 || objNote.intnote_id == 0) {
        return nil;
    }
    return objNote;
}
//--------------------------------------------------------------


//--------------------------------------------------------------
#pragma mark -
#pragma mark Favourites
//--------------------------------------------------------------
-(void) fnSetFavourite:(Favourites *)favourites {
    strQuery = [NSString stringWithFormat:@"UPDATE questions SET bookmark = 1 WHERE question_id = %d ", favourites.intquestion_id];
    error = [sqlManager doQuery:strQuery];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
}
-(void)fnDeleteFavourite:(Favourites *)favourites{
    strQuery = [NSString stringWithFormat:@"UPDATE questions SET bookmark = 0 WHERE question_id = %d ", favourites.intquestion_id];
    error = [sqlManager doQuery:strQuery];
	if (error != nil) {
		NSLog(@"Error: %@",[error localizedDescription]);
	}
    
}
-(Favourites *) fnCheckFavourites:(int)question_id AndChapterID:(int)chapter_id  AndQuizScoreId:(int)score_id {
    Favourites *objFavourites = [[Favourites alloc] init];
    strQuery = [NSString stringWithFormat:@"SELECT bookmark FROM questions WHERE question_id = %d",question_id];
    arrTempList = [sqlManager getRowsForQuery:strQuery];
    intRowCount = [arrTempList count];
    for (int i = 0; i < intRowCount; i++) {
        objFavourites.intfavourites_id  =   [[[arrTempList objectAtIndex:i] objectForKey:@"bookmark"] intValue];
    }
    if (intRowCount == 0 ||  objFavourites.intfavourites_id == 0) {
        return nil;
    }
    return objFavourites;
}
//--------------------------------------------------------------

@end
