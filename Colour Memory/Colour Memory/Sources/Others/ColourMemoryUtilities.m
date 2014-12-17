//
//  ColourMemoryUtilities.m
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/15/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#import "ColourMemoryUtilities.h"

#pragma mark -
@implementation ColourMemoryUtilities
#pragma mark - ColourMemoryUtilities Class Methods -
+ (NSString *)indexToPlace:(NSInteger)index
{
    NSString *contraction = @"";
    
    NSInteger teens = (index / 10);
    
    switch (index % 10)
    {
        case 1:
        {
            contraction = ((teens == 1) ? @"th" : @"st");
            break;
        }
        case 2:
        {
            contraction = ((teens == 1) ? @"th" : @"nd");
            break;
        }
        case 3:
        {
            contraction = ((teens == 1) ? @"th" : @"rd");
            break;
        }
        default:
        {
            contraction = @"th";
            break;
        }
    }
    
    return [NSString stringWithFormat:@"%ld%@", (long)index, contraction];
}

+ (NSString *)numberToPlace:(NSNumber *)index
{
    return [ColourMemoryUtilities indexToPlace:[index integerValue]];
}

@end