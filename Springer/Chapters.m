//
//  Chapters.m
//  XMLReader
//
//  Created by PUN-MAC-012 on 22/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Chapters.h"

@implementation Chapters
@synthesize intChapterId;
@synthesize strChapterTitle;
@synthesize arrQuestionSet;

- (id)init
{
    self = [super init];
    if (self) {
        strChapterTitle = [[NSMutableString alloc] init];
        arrQuestionSet = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
