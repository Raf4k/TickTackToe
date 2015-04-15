//
//  MainMenuViewController.m
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 09.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"
#import <GameKit/GameKit.h>



@interface MainMenuViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstPlayerName;
@property (weak, nonatomic) IBOutlet UITextField *secondPlayerName;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *singlePlayerButton;
@property (weak, nonatomic) IBOutlet UIButton *bluetoothButton;
@property BOOL enable;

@property (weak, nonatomic) NSLayoutConstraint *singlePlayerTopConstraint;
@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.leaderboardIdentifier = @"wins_in_a_row";
    self.enable = NO;
    self.firstPlayerName.hidden = YES;
    self.firstPlayerName.alpha = 0;
    self.secondPlayerName.alpha = 0;
    self.playButton.alpha = 0;
    self.secondPlayerName.hidden = YES;
    self.playButton.hidden = YES;
    
//    [self authenticateLocalPlayer];
    //add constraint 
    self.singlePlayerTopConstraint =[NSLayoutConstraint constraintWithItem:self.bluetoothButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.singlePlayerButton attribute:NSLayoutAttributeBottom multiplier:1 constant:14];
    [self.view addConstraint:self.singlePlayerTopConstraint];
    
    //hide keyboard
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Game Center

-(void)authenticateLocalPlayer{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                self.gameCenterAvaliable = YES;
                
                // Get the default leaderboard identifier.
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        self.leaderboardIdentifier = leaderboardIdentifier;
                    }
                }];
            } else{
                self.gameCenterAvaliable = NO;
            }
        }
    };
}

-(void)reportScore{
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:self.leaderboardIdentifier];
    score.value = self.highScore;
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error !=nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ViewController class]]) {
        ViewController *vc = segue.destinationViewController;
        vc.playerOneName = self.firstPlayerName.text;
        vc.playerTwoName = self.secondPlayerName.text;
    }
    
}

#pragma mark - Buttons

- (IBAction)singlePlayerButtonTapped:(id)sender {
   
    if (self.enable == NO) {
        [UIView animateWithDuration:1.3 animations:^{
            self.firstPlayerName.alpha = 1;
            self.secondPlayerName.alpha = 1;
            self.playButton.alpha = 1;
        }];
        [self singlePlayerActive];
    } else{
        [UIView animateWithDuration:1.0 animations:^{
            self.firstPlayerName.alpha = 0;
            self.secondPlayerName.alpha = 0;
            self.playButton.alpha = 0;
        } completion:^(BOOL finished) {
             [self singlePlayerDisactive];
        }];
    }
}

- (IBAction)gameCenterTapped:(id)sender {
//    self.highScore = 40;
//    [self reportScore];
}
- (IBAction)leaderboard:(id)sender {
    [self showLeaderboardAndAchievements];
}

- (IBAction)playButtonTapped:(id)sender {
    
    [UIView animateWithDuration:1.0 animations:^{
        self.firstPlayerName.alpha = 0;
        self.secondPlayerName.alpha = 0;
        self.playButton.alpha = 0;
    } completion:^(BOOL finished) {
        [self singlePlayerDisactive];
        
        //make navigation code
        
    }];
}
-(void)showLeaderboardAndAchievements{

    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
  
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = self.leaderboardIdentifier;
   
    
    [self presentViewController:gcViewController animated:YES completion:nil];
}

-(void)singlePlayerActive{
    
    self.firstPlayerName.hidden = NO;
    self.secondPlayerName.hidden = NO;
    self.playButton.hidden = NO;
    self.enable = YES;
    
    [self.view removeConstraint:self.singlePlayerTopConstraint];
    self.singlePlayerTopConstraint =[NSLayoutConstraint constraintWithItem:self.bluetoothButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.playButton attribute:NSLayoutAttributeBottom multiplier:1 constant:14];
    [self.view addConstraint:self.singlePlayerTopConstraint];
}

-(void)singlePlayerDisactive{
    self.firstPlayerName.hidden = YES;
    self.secondPlayerName.hidden = YES;
    self.playButton.hidden = YES;
    self.enable = NO;

    [self.view removeConstraint:self.singlePlayerTopConstraint];
    self.singlePlayerTopConstraint =[NSLayoutConstraint constraintWithItem:self.bluetoothButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.singlePlayerButton attribute:NSLayoutAttributeBottom multiplier:1 constant:14];
    [self.view addConstraint:self.singlePlayerTopConstraint];
}

-(void)dismissKeyboard {
    [self.firstPlayerName resignFirstResponder];
    [self.secondPlayerName resignFirstResponder];
}





@end
