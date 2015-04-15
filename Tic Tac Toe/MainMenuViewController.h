//
//  MainMenuViewController.h
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 09.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "MultiplayerGameViewController.h"
#import "GCHelper.h"

@interface MainMenuViewController : UIViewController <GCHelperDelegate>
@property BOOL gameCenterAvaliable;
@property double highScore;
@property (nonatomic, strong) NSString *leaderboardIdentifier;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) MultiplayerGameViewController *multiplayerGame;
@end
