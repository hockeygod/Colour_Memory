//
//  NameEntryForScoreViewController.m
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/16/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#import "NameEntryForScoreViewController.h"
#import "../Managers/PersistenceManager.h"
#import "../Others/ColourMemoryUtilities.h"

#pragma mark -
@interface NameEntryForScoreViewController () <UITextFieldDelegate>
#pragma mark - NameEntryForScoreViewController Private Properties -
@property   IBOutlet    UIView          *contentView;
@property   IBOutlet    UITextField     *nameField;
@property               CGFloat         keyboardAdjustmentApplied;

#pragma mark - NameEntryForScoreViewController Private Instance Methods -
- (IBAction)addButtonMethod:(id)sender;
- (IBAction)cancelButtonMethod:(id)sender;
- (IBAction)endEditingMethod:(id)sender;
- (void)keyboardNotification:(NSNotification *)notification;

@end

#pragma mark -
@implementation NameEntryForScoreViewController
#pragma mark - UIViewController Override Methods -
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate Protocol Methods -
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addButtonMethod:self];
    return YES;
}

#pragma mark - NameEntryForScoreViewController Private Instance Methods -
- (IBAction)addButtonMethod:(id)sender
{
    if ((self.nameField.text == nil) || ([self.nameField.text isEqualToString:@""]))
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Name field is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    [self.view endEditing:YES];
    NSNumber *rank = [[PersistenceManager persistanceManager] addToHighScores:self.nameField.text score:[NSNumber numberWithInteger:self.score]];
    if (rank != nil)
    {
        [[[UIAlertView alloc] initWithTitle:@"High Score Ranking" message:[NSString stringWithFormat:@"%@ with a score of %ld is %@", self.nameField.text, (long)self.score, [ColourMemoryUtilities numberToPlace:rank]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonMethod:(id)sender
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)endEditingMethod:(id)sender
{
    [self.view endEditing:NO];
}

- (void)keyboardNotification:(NSNotification *)notification
{
    CGRect endRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (endRect.origin.y >= self.view.frame.size.height)
    {
        self.keyboardAdjustmentApplied = -(self.keyboardAdjustmentApplied);
    }
    else
    {
        self.keyboardAdjustmentApplied = -(CGRectIntersection(self.contentView.frame, endRect).size.height);        
    }
    [UIView animateWithDuration:animationDuration animations:^{
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, (self.contentView.frame.origin.y + self.keyboardAdjustmentApplied), self.contentView.frame.size.width, self.contentView.frame.size.height);
    }];
}

@end
