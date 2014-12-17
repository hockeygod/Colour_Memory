//
//  PersistenceManager.h
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/15/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#pragma mark - persistanceManager Static Constants -
extern  NSInteger   highScoreCountLimit;

#pragma mark -
@interface PersistenceManager : NSObject
#pragma mark - PersistenceManager Class Methods -
+ (instancetype)persistanceManager;

#pragma mark - PersistenceManager Instance Methods -
- (NSArray *)highScores;
- (NSNumber *)addToHighScores:(NSString *)name score:(NSNumber *)score;
- (void)saveContext;

@end
