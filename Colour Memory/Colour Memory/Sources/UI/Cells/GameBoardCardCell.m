//
//  GameBoardCardCell.m
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/15/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#import "GameBoardCardCell.h"
#import "../../Managers/CardColourManager.h"

#pragma mark -
@interface GameBoardCardCell ()
#pragma mark - GameBoardCardCell Private Properties -
@property   NSInteger   privateColourNumber;

@end

#pragma mark -
@implementation GameBoardCardCell
#pragma mark - NSCoding Protocol Methods -
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self != nil)
    {
        [self setImage:[UIImage imageNamed:@"card_bg"]];
        self.colourNumber = [CardColourManager randomCardColour];
    }
    
    return self;
}

#pragma mark - GameBoardCardCell Instance Methods -
- (NSInteger)colourNumber
{
    return self.privateColourNumber;
}

- (void)setColourNumber:(NSInteger)colourNumber
{
    self.privateColourNumber = colourNumber;
    [self setHighlightedImage:[UIImage imageNamed:[NSString stringWithFormat:@"colour%ld", (long)self.colourNumber]]];
}

@end
