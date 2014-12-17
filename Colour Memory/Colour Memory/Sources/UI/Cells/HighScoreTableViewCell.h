//
//  HighScoreTableViewCell.h
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/15/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#pragma mark -
@interface HighScoreTableViewCell : UITableViewCell
#pragma mark - HighScoreTableViewCell Properties -
@property   IBOutlet    UILabel     *rank;
@property   IBOutlet    UILabel     *name;
@property   IBOutlet    UILabel     *score;

@end
