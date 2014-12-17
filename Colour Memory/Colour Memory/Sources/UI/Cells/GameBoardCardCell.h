//
//  GameBoardCardCell.h
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/15/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#pragma mark -
@interface GameBoardCardCell : UIImageView
#pragma mark - GameBoardCardCell Instance Methods -
- (NSInteger)colourNumber;
- (void)setColourNumber:(NSInteger)colourNumber;

@end
