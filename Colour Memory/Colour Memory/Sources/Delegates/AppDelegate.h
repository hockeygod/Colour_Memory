//
//  AppDelegate.h
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/11/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#pragma mark -
@interface AppDelegate : UIResponder <UIApplicationDelegate>
#pragma mark - AppDelegate Properties -
@property (strong, nonatomic) UIWindow *window;

#pragma mark - AppDelegate Class Methods -
+ (instancetype)appDelegate;

#pragma mark - AppDelegate Instance Methods -
- (NSURL *)applicationDocumentsDirectory;

@end

