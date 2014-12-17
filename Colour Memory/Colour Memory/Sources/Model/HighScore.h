//
//  HighScore.h
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/15/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#pragma mark -
@interface HighScore : NSManagedObject
#pragma mark - HighScore Properties -
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * score;

@end
