//
//  XmlReader.h
//  Springer1.1
//
//  Created by PUN-MAC-012 on 31/01/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Questions;
@class Chapters;

@interface XmlReader : NSObject <NSXMLParserDelegate>
{
    @private
    NSMutableArray *arrayQuestions;
	NSXMLParser *xmlParser;
	NSString * currentElement;
	Questions *currentQuestions;
    Chapters *currentChapter;
}

@property (nonatomic, retain) NSMutableArray *arrayChapters;


-(NSMutableArray *) fnReadXml;

@end
