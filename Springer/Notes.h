//
//  Notes.h
//  Springer
//
//  Created by systems pune on 09/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notes : NSObject

@property (nonatomic)NSInteger intnote_id;
@property (nonatomic)NSInteger intquestion_id;
@property (nonatomic)NSInteger intchapter_id;
@property (nonatomic)NSInteger intquiz_ids;
@property (nonatomic)NSInteger intscore_id;
@property (nonatomic,retain)NSString *strnote_desc;
@property (nonatomic,retain)NSString *strmodified_date;
@property (nonatomic,retain)NSString *strcreated_date;
@property (nonatomic)NSInteger intmode;

@end
