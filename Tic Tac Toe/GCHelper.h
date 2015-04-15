//
//  GCHelper.h
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 15.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol GCHelperDelegate
-(void)matchStarted;
-(void)matchEnded;
- (void)match:(GKMatch *)match didReceiveData:(NSData *)data
   fromPlayer:(NSString *)playerID;
-(void)inviteRecived;

@end

@interface GCHelper : NSObject <GKMatchmakerViewControllerDelegate, GKMatchDelegate>

@property BOOL userAuthenticated;
@property BOOL gameCenterAvailable;

@property (nonatomic, retain) UIViewController *presentingViewController;
@property (nonatomic, retain) GKMatch *match;
@property BOOL matchStarted;
@property (nonatomic, strong) id <GCHelperDelegate> delegate;

@property (nonatomic, strong) NSMutableDictionary *playersDict;

@property (nonatomic, strong) GKInvite *pendingInvite;
@property (nonatomic, strong) NSArray *pendingPlayersToInvite;


+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser;

-(void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController delegate:(id<GCHelperDelegate>)theDelegate;

@end
