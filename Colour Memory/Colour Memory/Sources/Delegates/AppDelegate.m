//
//  AppDelegate.m
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/11/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#import "AppDelegate.h"
#import "../Managers/PersistenceManager.h"

#pragma mark -
@implementation AppDelegate
#pragma mark - UIApplicationDelegate Protocol Methods -
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[PersistenceManager persistanceManager] saveContext];
}

#pragma mark - AppDelegate Static Variables -
static  AppDelegate     *_appDelegateSingleton  =   nil;
static  dispatch_once_t _appDelegateOnceToken   =   0;

#pragma mark - AppDelegate Class Methods -
+ (instancetype)appDelegate
{
    dispatch_once(&_appDelegateOnceToken, ^{
        _appDelegateSingleton = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    });
    
    return _appDelegateSingleton;
}

#pragma mark - AppDelegate Instance Methods -
- (NSURL *)applicationDocumentsDirectory
{
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.eevl.productions.Colour_Memory" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
