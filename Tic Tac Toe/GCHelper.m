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





//- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers
//                 viewController:(UIViewController *)viewController
//                       delegate:(id<GCHelperDelegate>)theDelegate {
//    
//    if (!self.gameCenterAvailable) return;
//    
//    self.matchStarted = NO;
//    self.match = nil;
//    self.presentingViewController = viewController;
//    self.delegate = theDelegate;
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    
//    GKMatchRequest *request = [[GKMatchRequest alloc] init];
//    request.minPlayers = minPlayers;
//    request.maxPlayers = maxPlayers;
//    
//    GKMatchmakerViewController *mmvc =
//    [[GKMatchmakerViewController alloc] initWithMatchRequest:request];
//    mmvc.matchmakerDelegate = self;
//    
//    [self.presentingViewController presentViewController:mmvc animated:YES completion:nil];
//}




@end
