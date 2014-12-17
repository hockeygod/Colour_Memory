//
//  HighScoreViewController.m
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/13/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#import "HighScoreViewController.h"
#import "../Managers/PersistenceManager.h"
#import "../Model/HighScore.h"
#import "../Others/ColourMemoryUtilities.h"
#import "../UI/Cells/HighScoreTableViewCell.h"

#pragma mark -
@interface HighScoreViewController () <UITableViewDataSource>
#pragma mark - HighScoreViewController Private Instance Methods -
- (IBAction)gameBoardButtonPressed:(id)sender;

@end

#pragma mark -
@implementation HighScoreViewController
#pragma mark - UIViewController Override Methods -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Protocol Methods -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[PersistenceManager persistanceManager] highScores] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HighScoreTableViewCell";
    
    HighScoreTableViewCell *returnCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (returnCell == nil)
    {
        returnCell = [[[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil] objectAtIndex:0];
    }
    
    HighScore *highScore = [[[PersistenceManager persistanceManager] highScores] objectAtIndex:indexPath.row];
    [[returnCell rank] setText:[ColourMemoryUtilities indexToPlace:(indexPath.row + 1)]];
    [[returnCell name] setText:[highScore name]];
    [[returnCell score] setText:[[highScore score] stringValue]];
    
    return returnCell;
}

#pragma mark - HighScoreViewController Private Instance Methods -
- (IBAction)gameBoardButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end