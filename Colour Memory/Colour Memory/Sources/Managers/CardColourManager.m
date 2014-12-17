//
//  CardColourManager.m
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/15/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#import "CardColourManager.h"

#pragma mark -
@implementation CardColourManager
#pragma mark - CardColourManager Static Variables -
static u_int32_t        numberOfColours                         =   8;
static NSInteger        *cardColourNumbersAlreadyUsed           =   nil;
static dispatch_once_t  cardColourNumbersAlreadyUsedOnceToken   =   0;

#pragma mark - CardColourManager Class Methods -
+ (NSInteger)randomCardColour
{
    dispatch_once(&cardColourNumbersAlreadyUsedOnceToken, ^{
        cardColourNumbersAlreadyUsed = calloc(16, sizeof(NSInteger));
        for (NSInteger x = 0; x < 16; x++)
        {
            cardColourNumbersAlreadyUsed[x] = NSIntegerMin;
        }
    });
    
    NSInteger returnCardColourNumber = NSIntegerMin;
    while (returnCardColourNumber == NSIntegerMin)
    {
        returnCardColourNumber = arc4random_uniform(numberOfColours);
        
        if (cardColourNumbersAlreadyUsed[returnCardColourNumber] == NSIntegerMin)
        {
            cardColourNumbersAlreadyUsed[returnCardColourNumber] = returnCardColourNumber;
        }
        else if (cardColourNumbersAlreadyUsed[returnCardColourNumber + numberOfColours] == NSIntegerMin)
        {
            cardColourNumbersAlreadyUsed[returnCardColourNumber + numberOfColours] = returnCardColourNumber;
        }
        else
        {
            returnCardColourNumber = NSIntegerMin;
        }
    }

    return (returnCardColourNumber + 1);
}

+ (void)reset
{
    free(cardColourNumbersAlreadyUsed);
    cardColourNumbersAlreadyUsed = nil;
    cardColourNumbersAlreadyUsedOnceToken = 0;
}

@end
