//
//  GCHelper.m
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 15.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import "GCHelper.h"
#import <GameKit/GameKit.h>

@implementation GCHelper


#pragma mark Initialization

static GCHelper *sharedHelper = nil;
+ (GCHelper *) sharedInstance {
    if (!sharedHelper) {
        sharedHelper = [[GCHelper alloc] init];
    }
    return sharedHelper;
}

- (BOOL)isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

- (id)init {
    if ((self = [super init])) {
        self.gameCenterAvailable = [self isGameCenterAvailable];
        if (self.gameCenterAvailable) {
            NSNotificationCenter *nc =
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self
                   selector:@selector(authenticationChanged)
                       name:GKPlayerAuthenticationDidChangeNotificationName
                     object:nil];
        }
    }
    return self;
}

- (void)authenticationChanged {
    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !self.userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        self.userAuthenticated = TRUE;
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && self.userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        self.userAuthenticated = FALSE;
    }
}

- (void)authenticateLocalUser {
    
    if (!self.gameCenterAvailable) return;
    
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    } else {
        NSLog(@"Already authenticated!");
    }
}

-(void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController delegate:(id<GCHelperDelegate>)theDelegate{
    
    if (!self.gameCenterAvailable) return;
    
    self.match = nil;
    self.presentingViewController = viewController;
    self.delegate = theDelegate;
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    
    GKMatchRequest *request = [[GKMatchRequest alloc] init];
    request.minPlayers = minPlayers;
    request.maxPlayers = maxPlayers;
    GKMatchmakerViewController *mmvc = [[GKMatchmakerViewController alloc] initWithMatchRequest:request];
    mmvc.matchmakerDelegate = self;
    
    [self.presentingViewController presentViewController:mmvc animated:YES completion:nil];
    
}

#pragma mark GKMatchmakerViewControllerDelegate

//The user has cancelled matchmaking

-(void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//Matchmaking has failed with an error

-(void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Error finding match: %@", error.localizedDescription);
}

//A peer to peer match has been found, the game should start

-(void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)match{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    self.match = match;
    self.match.delegate = self;
    
    if (!self.matchStarted && self.match.expectedPlayerCount == 0) {
        NSLog(@"Ready to start match");
    }
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data
   fromPlayer:(NSString *)playerID{
    
    if (self.match !=match) return;
    [self.delegate match:match didReceiveData:data fromPlayer:playerID];
}

-(void)match:(GKMatch *)match player:(GKPlayer *)player didChangeConnectionState:(GKPlayerConnectionState)state{
    
    if (self.match !=match) return;
    
    switch (state) {
        case GKPlayerStateConnected:
            //handle a new player connection
            NSLog(@"Player connected!");
            
            if (!self.matchStarted && match.expectedPlayerCount == 0) {
                NSLog(@"Ready to start match !");
            }
            break;
        case GKPlayerStateDisconnected:
            // a player just disconnected
            NSLog(@"Player disconnected!");
            self.matchStarted = NO;
            [self.delegate matchEnded];
            break;
        default:
            break;
    }
}

//The match was unable to be established with any players due to an error;

-(void)match:(GKMatch *)match connectionWithPlayerFailed:(NSString *)playerID withError:(NSError *)error{
    if (self.match != match) return;
    
    NSLog(@"Failed to connect to player with error :%@", error.localizedDescription);
    self.matchStarted = NO;
    [self.delegate matchEnded];
}


-(void)match:(GKMatch *)match didFailWithError:(NSError *)error{
    if (self.match == match) return;
    
    NSLog(@"Match failed with error :%@", error.localizedDescription);
    self.matchStarted = NO;
  [self.delegate matchEnded];
}






@end
