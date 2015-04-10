//
//  SmallXOVIewController.m
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 07.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import "SmallXOVIewController.h"

@interface SmallXOVIewController ()


@end

@implementation SmallXOVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.winnerX.hidden = YES;
    self.winnerX.alpha = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)topLeftTapped:(id)sender {
    [self.delegate TouchButton:sender];
     [self checkWinner];
    [self.delegate didSelectSmallXO:eXOPositionTopLeft];
}
- (IBAction)topCenterTapped:(id)sender {
    [self.delegate TouchButton:sender];
    [self checkWinner];
    [self.delegate didSelectSmallXO:eXOPositionTopCenter];
}
- (IBAction)topRightTapped:(id)sender {
    [self.delegate TouchButton:sender];
     [self checkWinner];
    [self.delegate didSelectSmallXO:eXOPositionTopRight];
}
- (IBAction)centerLeftTapped:(id)sender {
    [self.delegate TouchButton:sender];
     [self checkWinner];
    [self.delegate didSelectSmallXO:eXOPositionCenterLeft];
}
- (IBAction)centerCenterTapped:(id)sender {
    [self.delegate TouchButton:sender];
     [self checkWinner];
    [self.delegate didSelectSmallXO:eXOPositionCenterCenter];
}
- (IBAction)centerRightTapped:(id)sender {
    [self.delegate TouchButton:sender];
     [self checkWinner];
    [self.delegate didSelectSmallXO:eXOPositionCenterRight];
}
- (IBAction)bottomLeftTapped:(id)sender {
    [self.delegate TouchButton:sender];
     [self checkWinner];
    [self.delegate didSelectSmallXO:eXOPositionBottomLeft];
}
- (IBAction)bottomCenterTapped:(id)sender {
    [self.delegate TouchButton:sender];
     [self checkWinner];
    [self.delegate didSelectSmallXO:eXOPositionBottomCenter];
}
- (IBAction)bottomRightTapped:(id)sender {
    [self.delegate TouchButton:sender];
     [self checkWinner];
    [self.delegate didSelectSmallXO:eXOPositionBottomRight];
}

//conditions when player win small board
-(void)checkWinner{
    if (self.topLeft.tag == 1 && self.topCenter.tag == 1&& self.topRight.tag == 1) {
       [self winSecondPlayer];
    }
    else if (self.centerLeft.tag  == 1&& self.centerCenter.tag == 1 && self.centerRight.tag == 1) {
       [self winSecondPlayer];
    }
    else if (self.bottomLeft.tag == 1 && self.bottomCenter.tag == 1 && self.bottomRight.tag == 1){
        [self winSecondPlayer];
    }
    else if (self.topLeft.tag == 1 && self.centerLeft.tag == 1 && self.bottomLeft.tag == 1){
       [self winSecondPlayer];
    }
    else if (self.topCenter.tag == 1 && self.centerCenter.tag == 1 && self.bottomCenter.tag == 1){
       [self winSecondPlayer];
    }
    else if (self.topRight.tag == 1 && self.centerRight.tag == 1 && self.bottomRight.tag == 1){
        [self winSecondPlayer];
    }
    else if (self.topLeft.tag == 1 && self.centerCenter.tag == 1 && self.bottomRight.tag == 1){
        [self winSecondPlayer];
    }
    else if (self.topRight.tag == 1 && self.centerCenter.tag == 1 && self.bottomLeft.tag == 1){
       [self winSecondPlayer];
    }
    else if (self.topLeft.tag == 2 && self.topCenter.tag == 2 && self.topRight.tag == 2) {
       [self winFirstPlayer];
    }
    else if (self.centerLeft.tag == 2 && self.centerCenter.tag == 2 && self.centerRight.tag == 2) {
       [self winFirstPlayer];
    }
    else if (self.bottomLeft.tag == 2 && self.bottomCenter.tag == 2 && self.bottomRight.tag == 2){
       [self winFirstPlayer];
    }
    else if (self.topLeft.tag  == 2 && self.centerLeft.tag == 2 && self.bottomLeft.tag == 2){
     [self winFirstPlayer];
    }
    else if (self.topCenter.tag == 2 && self.centerCenter.tag == 2 && self.bottomCenter.tag == 2){
        [self winFirstPlayer];
    }
    else if (self.topRight.tag == 2 && self.centerRight.tag == 2 && self.bottomRight.tag == 2){
       [self winFirstPlayer];
    }
    else if (self.topLeft.tag == 2 && self.centerCenter.tag == 2 && self.bottomRight.tag == 2){
       [self winFirstPlayer];
    }
    else if (self.topRight.tag == 2 && self.centerCenter.tag == 2 && self.bottomLeft.tag == 2){
        [self winFirstPlayer];
    }
    else if (self.topRight.tag && self.topLeft.tag && self.topCenter.tag && self.centerLeft.tag && self.centerCenter.tag && self.centerRight.tag && self.bottomLeft.tag && self.bottomCenter.tag && self.bottomRight.tag){
        NSLog(@"Pat");
        self.winner = eWinnerPat;
    } else {
        self.winner = eWinnerNone;
    }
}

//animations if player win small board

-(void)winFirstPlayer{
    NSLog(@"First player wins");
    self.winnerX.image = [UIImage imageNamed:@"o"];
    [UIView animateWithDuration:1.3 animations:^{
        self.winnerX.hidden = NO;
        self.winnerX.alpha = 1;
    }];
    self.winner = eWinnerPlayer1;
}

-(void)winSecondPlayer{
    NSLog(@"First player wins");
    self.winnerX.image = [UIImage imageNamed:@"x"];
    [UIView animateWithDuration:1.3 animations:^{
        self.winnerX.hidden = NO;
        self.winnerX.alpha = 1;
    }];
    self.winner = eWinnerPlayer2;
}


@end
