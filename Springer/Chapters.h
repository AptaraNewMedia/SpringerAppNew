//
//  Chapters.h
//  XMLReader
//
//  Created by PUN-MAC-012 on 22/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Chapters : NSObject

@property (nonatomic) NSInteger intChapterId;
@property (nonatomic, retain) NSMutableString *strChapterTitle;
@property (nonatomic, retain) NSMutableArray *arrQuestionSet;
@property (nonatomic) NSInteger intQuestionCount;

@end
