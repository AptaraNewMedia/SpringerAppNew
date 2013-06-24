//
//  Favourites.h
//  Springer
//
//  Created by PUN-MAC-012 on 22/05/13.
//  Copyright (c) 2013 PUN-MAC-012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Favourites : NSObject

@property (nonatomic)NSInteger intfavourites_id;
@property (nonatomic)NSInteger intquestion_id;
@property (nonatomic)NSInteger intchapter_id;
@property (nonatomic)NSInteger intscore_id;
@property (nonatomic,retain)NSString *strmodified_date;
@property (nonatomic,retain)NSString *strcreated_date;
@property (nonatomic)NSInteger intmode;

@end
