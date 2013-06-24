//
//  XmlReader.m
//  Springer1.1
//
//  Created by PUN-MAC-012 on 31/01/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import "XmlReader.h"
#import "Questions.h"
#import "Chapters.h"

@implementation XmlReader

@synthesize arrayChapters;

-(NSMutableArray *) fnReadXml
{
    arrayChapters = [[NSMutableArray alloc] init];
    
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"Fernandez" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    [xmlParser setDelegate:self];
	[xmlParser setShouldProcessNamespaces:NO];
	[xmlParser setShouldReportNamespacePrefixes:NO];
	[xmlParser setShouldResolveExternalEntities:YES];
	[xmlParser parse];
    
    return arrayChapters;
}


#pragma mark -
#pragma mark NSXMLParserDelegate methods
#pragma mark - NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    currentElement = [elementName copy];
    
    if ([elementName isEqualToString:@"chapter"]) {
        currentChapter = [[Chapters alloc] init];
        //NSLog(@"<chapter>");
    }
	else if ([elementName isEqualToString:@"question"]) {
		currentQuestions = [[Questions alloc] init];
        //NSLog(@"<question>");
	}
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    NSString *trimString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimString.length > 0) {
        if ([currentElement isEqualToString:@"chapterno"]) {
            currentChapter.intChapterId  = [trimString integerValue];
        } else if ([currentElement isEqualToString:@"title"]) {
            [currentChapter.strChapterTitle appendString:string];
        } else if ([currentElement isEqualToString:@"questionid"]) {
            currentQuestions.intQuestionId = [trimString integerValue];
        } else if ([currentElement isEqualToString:@"type"]) {
            [currentQuestions.strQuestionType	appendString:string];
        } else if ([currentElement isEqualToString:@"strokeanswer"]) {
            [currentQuestions.strStrokeAnswer	appendString:string];
        }  else if ([currentElement isEqualToString:@"imagepath"]) {
            [currentQuestions.arrImagePaths addObject:string];
        }
        
    }
}

-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    NSString *someString = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    if ([currentElement isEqualToString:@"text"]) {
        [currentQuestions.strQuestionText	appendString:someString];
    }
    else if ([currentElement isEqualToString:@"rationaletext"]) {
        [currentQuestions.strFeedback	appendString:someString];
    }
    else if ([currentElement isEqualToString:@"option"]) {
        [currentQuestions.arrOptions addObject:someString];
    } else if ([currentElement isEqualToString:@"answer"]) {
        [currentQuestions.arrAnswers addObject:someString];
    }
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI   qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"chapter"]) {
        //NSLog(@"</chapter>");
        [arrayChapters addObject:currentChapter];
    }
    else if ([elementName isEqualToString:@"question"]) {
		[currentChapter.arrQuestionSet addObject:currentQuestions];
        //NSLog(@"</question>");
	}
}


@end
