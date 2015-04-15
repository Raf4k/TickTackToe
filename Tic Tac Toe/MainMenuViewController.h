//
//  MainMenuViewController.h
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 09.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface MainMenuViewController : UIViewController

@property BOOL gameCenterAvaliable;
@property double highScore;
@property (nonatomic, strong) NSString *leaderboardIdentifier;

@end
