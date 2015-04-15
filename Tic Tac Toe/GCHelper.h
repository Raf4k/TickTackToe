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
//-(void)match:(GKMatch *)match didReceiveData:(NSData *)data fromRemotePlayer:(GKPlayer *)player;
@end

@interface GCHelper : NSObject <GKMatchmakerViewControllerDelegate, GKMatchDelegate>

@property BOOL userAuthenticated;
@property BOOL gameCenterAvailable;
@property BOOL matchStarted;

@property (nonatomic, strong) GKMatch *match;

@property (nonatomic, strong) id <GCHelperDelegate> delegate;



+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser;
//-(void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController delegate:(id<GCHelperDelegate>)theDelegate;

@end
