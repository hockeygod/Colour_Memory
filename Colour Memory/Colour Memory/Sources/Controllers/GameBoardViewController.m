//
//  ViewController.m
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/11/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#import "GameBoardViewController.h"
#import "HighScoreViewController.h"
#import "NameEntryForScoreViewController.h"

#import "../Managers/CardColourManager.h"
#import "../Managers/PersistenceManager.h"
#import "../Model/HighScore.h"
#import "../Others/ColourMemoryUtilities.h"
#import "../UI/Cells/GameBoardCardCell.h"

#pragma mark -
@interface GameBoardViewController () <UIAlertViewDelegate, UITextFieldDelegate>
#pragma mark - GameBoardViewController Private Properties -
@property   IBOutlet    UILabel             *currentScoreLabel;
@property               GameBoardCardCell   *card1;
@property               GameBoardCardCell   *card2;
@property               NSInteger           currentScore;

#pragma mark - GameBoardViewController Private Instance Methods -
- (IBAction)tapGestureRecognizerMethod:(UITapGestureRecognizer *)sender;
- (IBAction)highScoreButtonPressed:(id)sender;
- (void)reset;
@end

#pragma mark -
@implementation GameBoardViewController
#pragma mark - UIViewController Override Methods -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.currentScore = 0;
    self.currentScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.currentScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GameBoardViewController Private Instance Methods -
- (IBAction)tapGestureRecognizerMethod:(UITapGestureRecognizer *)sender
{
    GameBoardCardCell *tappedGameBoardCardCell = (GameBoardCardCell *)[self.view hitTest:[sender locationInView:self.view] withEvent:nil];
    
    if (tappedGameBoardCardCell == nil)
        return;
    
    if (tappedGameBoardCardCell == self.card1)
        return;
    
    if (self.card1 == nil)
    {
        self.card1 = tappedGameBoardCardCell;
        self.card1.highlighted = YES;
    }
    else if(self.card2 == nil)
    {
        self.card2 = tappedGameBoardCardCell;
        self.card2.highlighted = YES;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.card1.colourNumber != self.card2.colourNumber)
            {
                self.card1.highlighted = NO;
                self.card2.highlighted = NO;
                self.card1 = nil;
                self.card2 = nil;
                self.currentScore = (self.currentScore - 1);
                self.currentScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.currentScore];
            }
            else
            {
                self.card1.highlighted = NO;
                self.card1.hidden = YES;
                self.card2.highlighted = NO;
                self.card2.hidden = YES;
                self.card1 = nil;
                self.card2 = nil;
                self.currentScore = (self.currentScore + 2);
                self.currentScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.currentScore];
            }
            //If no more cards visible, show NameEntryForScoreViewController
            BOOL displayNameEntryForScoreView = YES;
            
            for (UIView *aView in self.view.subviews)
            {
                if ([aView isKindOfClass:[GameBoardCardCell class]])
                {
                    if (aView.hidden == NO)
                    {
                        displayNameEntryForScoreView = NO;
                        break;
                    }
                }
            }
            
            if (displayNameEntryForScoreView)
            {
                //If currentScore within range, show NameEntryForScoreViewController
                NSArray *highScores = [[PersistenceManager persistanceManager] highScores];
                if ((highScores.count < highScoreCountLimit) || (self.currentScore > ((HighScore *)highScores.lastObject).score.integerValue))
                {
                    NameEntryForScoreViewController *nEFSVC = [NameEntryForScoreViewController new];
                    nEFSVC.score = self.currentScore;
                    [self presentViewController:nEFSVC animated:YES completion:nil];
                }
                [self reset];
            }
        });
    }
}

- (IBAction)highScoreButtonPressed:(id)sender
{
    HighScoreViewController *hSTVC = [HighScoreViewController new];
    [self presentViewController:hSTVC animated:YES completion:nil];
}

- (void)reset
{
    [CardColourManager reset];
    
    for (UIView *aView in self.view.subviews)
    {
        if ([aView isKindOfClass:[GameBoardCardCell class]])
        {
            if (aView.hidden == YES)
            {
                ((GameBoardCardCell *)aView).colourNumber = [CardColourManager randomCardColour];
                aView.hidden = NO;
            }
        }
    }
    
    self.currentScore = 0;
    self.currentScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.currentScore];
    self.card1 = nil;
    self.card2 = nil;
}

@end