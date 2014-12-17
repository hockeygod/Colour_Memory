//
//  PersistenceManager.m
//  Colour Memory
//
//  Created by Eric E. van Leeuwen on 12/15/14.
//  Copyright (c) 2014 Eric E. van Leeuwen. All rights reserved.
//

#import "PersistenceManager.h"
#import "../Delegates/AppDelegate.h"
#import "../Model/HighScore.h"

#pragma mark - persistanceManager Static Constants -
NSInteger   highScoreCountLimit =   10;

#pragma mark -
@interface PersistenceManager ()
#pragma mark - PersistenceManager Private Properties -
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

#pragma mark -
@implementation PersistenceManager
#pragma mark - PersistenceManager Class Methods -
+ (instancetype)persistanceManager
{
    static PersistenceManager *_persistanceManagerSingleton = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _persistanceManagerSingleton = [PersistenceManager new];
    });
    
    return _persistanceManagerSingleton;
}

#pragma mark - PersistenceManager Instance Methods -
- (NSArray *)highScores
{
    NSArray *returnArray = nil;

    NSFetchRequest *highScoresFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"HighScore"];
    [highScoresFetchRequest setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO]]];
    [highScoresFetchRequest setFetchLimit:highScoreCountLimit];
    NSError *highScoresError;
    returnArray = [[self managedObjectContext] executeFetchRequest:highScoresFetchRequest error:&highScoresError];
    if (highScoresError != nil)
    {
        NSLog(@"%s encountered error:\t%@", __PRETTY_FUNCTION__, highScoresError);
    }
    return returnArray;
}

- (NSNumber *)addToHighScores:(NSString *)name score:(NSNumber *)score
{
    HighScore *newHighScore = (HighScore *)[NSEntityDescription insertNewObjectForEntityForName:@"HighScore" inManagedObjectContext:self.managedObjectContext];
    [newHighScore setName:name];
    [newHighScore setScore:score];
    [self saveContext];
    
    NSArray *highScores = [self highScores];
    return (([highScores indexOfObject:newHighScore] != NSNotFound) ? [NSNumber numberWithInteger:([highScores indexOfObject:newHighScore] + 1)] : nil);
}

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - PersistenceManager Private Properties -
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Colour_Memory" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[[AppDelegate appDelegate] applicationDocumentsDirectory] URLByAppendingPathComponent:@"Colour_Memory.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

@end
