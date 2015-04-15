//
//  ViewController.m
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 07.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import "ViewController.h"
#import "SmallXOVIewController.h"


@interface ViewController () <SmallXODelegate>
@property (weak, nonatomic) IBOutlet UIView *topLeftContainer;
@property (weak, nonatomic) IBOutlet UIView *topCenterContainer;
@property (weak, nonatomic) IBOutlet UIView *topRightContainer;

@property (weak, nonatomic) IBOutlet UIView *centerLeftContainer;
@property (weak, nonatomic) IBOutlet UIView *centerCenterContainer;
@property (weak, nonatomic) IBOutlet UIView *centerRightContainer;

@property (weak, nonatomic) IBOutlet UIView *bottomLeftContainer;
@property (weak, nonatomic) IBOutlet UIView *bottomCenterContainer;
@property (weak, nonatomic) IBOutlet UIView *bottomRightContainer;

@property (strong, nonatomic) SmallXOVIewController *topLeft;
@property (strong, nonatomic) SmallXOVIewController *topCenter;
@property (strong, nonatomic) SmallXOVIewController *topRight;

@property (strong, nonatomic) SmallXOVIewController *centerLeft;
@property (strong, nonatomic) SmallXOVIewController *centerCenter;
@property (strong, nonatomic) SmallXOVIewController *centerRight;

@property (strong, nonatomic) SmallXOVIewController *bottomLeft;
@property (strong, nonatomic) SmallXOVIewController *bottomCenter;
@property (strong, nonatomic) SmallXOVIewController *bottomRight;

@property BOOL player;

@property (weak, nonatomic) IBOutlet UILabel *playersTurn;
@property (weak, nonatomic) IBOutlet UIImageView *playersTicTacToe;
@property (nonatomic, strong) NSArray *array;
@property (weak, nonatomic) IBOutlet UILabel *labelWinner;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //if players do not wrote names

    if ([self.playerOneName isEqualToString:@""]) {
        self.playerOneName = @"Player: 1";
    }else{
    self.playersTurn.text = self.playerOneName;
    }
    
    if ([self.playerTwoName isEqualToString:@""]) {
        self.playerTwoName = @"Player: 2";
    }
   
    
    self.winnerContainer.hidden = YES;
    self.winnerContainer.alpha = 0;
    self.labelWinner.hidden = YES;
    self.labelWinner.alpha = 0;
    
    self.topLeft = [SmallXOVIewController new];
    self.topLeft.delegate = self;
    [self.topLeftContainer addSubview:self.topLeft.view];
    [self addChildViewController:self.topLeft];
    
    self.topCenter = [SmallXOVIewController new];
    self.topCenter.delegate = self;
    [self.topCenterContainer addSubview:self.topCenter.view];
    [self addChildViewController:self.topCenter];
    
    self.topRight = [SmallXOVIewController new];
    self.topRight.delegate = self;
    [self.topRightContainer addSubview:self.topRight.view];
    [self addChildViewController:self.topRight];
    
    self.centerLeft = [SmallXOVIewController new];
    self.centerLeft.delegate = self;
    [self.centerLeftContainer addSubview:self.centerLeft.view];
    [self addChildViewController:self.centerLeft];
    
    self.centerCenter = [SmallXOVIewController new];
    self.centerCenter.delegate = self;
    [self.centerCenterContainer addSubview:self.centerCenter.view];
    [self addChildViewController:self.centerCenter];
    
    self.centerRight = [SmallXOVIewController new];
    self.centerRight.delegate = self;
    [self.centerRightContainer addSubview:self.centerRight.view];
    [self addChildViewController:self.centerRight];
    
    self.bottomLeft = [SmallXOVIewController new];
    self.bottomLeft.delegate = self;
    [self.bottomLeftContainer addSubview:self.bottomLeft.view];
    [self addChildViewController:self.bottomLeft];
    
    self.bottomCenter = [SmallXOVIewController new];
    self.bottomCenter.delegate = self;
    [self.bottomCenterContainer addSubview:self.bottomCenter.view];
    [self addChildViewController:self.bottomCenter];
    
    self.bottomRight = [SmallXOVIewController new];
    self.bottomRight.delegate = self;
    [self.bottomRightContainer addSubview:self.bottomRight.view];
    [self addChildViewController:self.bottomRight];
    
    self.topLeft.winner = eWinnerNone;
    self.topCenter.winner = eWinnerNone;
    self.topRight.winner = eWinnerNone;
    self.centerLeft.winner = eWinnerNone;
    self.centerCenter.winner = eWinnerNone;
    self.centerRight.winner = eWinnerNone;
    self.bottomLeft.winner = eWinnerNone;
    self.bottomCenter.winner = eWinnerNone;
    self.bottomRight.winner = eWinnerNone;
    
    
    self.array = @[self.topLeft, self.topCenter, self.topRight, self.centerLeft, self.centerCenter, self.centerRight, self.bottomLeft, self.bottomCenter, self.bottomRight];
}


//delegate touch button

-(void)TouchButton:(UIButton *)button{
    
    if (self.player) {
        self.player = NO;
        [button setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
        button.tintColor = [UIColor redColor];
        button.tag = 1;
         button.userInteractionEnabled = NO;
        self.playersTurn.text = self.playerOneName;
        self.playersTicTacToe.image = [UIImage imageNamed:@"o"];
        NSLog(@"NO");
    }else{
    self.player = YES;
     [button setImage:[UIImage imageNamed:@"o"] forState:UIControlStateNormal];
    NSLog(@"YES");
    button.tag = 2;
    button.userInteractionEnabled = NO;
    self.playersTurn.text = self.playerTwoName;
    self.playersTicTacToe.image = [UIImage imageNamed:@"x"];
    button.tintColor = [UIColor greenColor];
    }
    NSLog(@"%ld",(long)[button tag]);
   
   
    
}

//method to block small boards

-(void)didSelectSmallXO:(eXOPosition)selectedXOPosition{
    switch (selectedXOPosition) {
        case eXOPositionTopLeft:
            [self blockAllExcept:self.topLeft];
            break;
        case eXOPositionTopCenter:
            [self blockAllExcept:self.topCenter];
            break;
        case eXOPositionTopRight:
            [self blockAllExcept:self.topRight];
            break;
        case eXOPositionCenterLeft:
            [self blockAllExcept:self.centerLeft];
            break;
        case eXOPositionCenterCenter:
            [self blockAllExcept:self.centerCenter];
            break;
        case eXOPositionCenterRight:
            [self blockAllExcept:self.centerRight];
            break;
        case eXOPositionBottomLeft:
            [self blockAllExcept:self.bottomLeft];
            break;
        case eXOPositionBottomCenter:
            [self blockAllExcept:self.bottomCenter];
            break;
        case eXOPositionBottomRight:
            [self blockAllExcept:self.bottomRight];
            break;
            
        default:
            break;
    }
}

-(void)blockAllExcept:(SmallXOVIewController *)selectedSmallXO{
    
    [selectedSmallXO checkWinner];
     [self checkWinner];
    if (selectedSmallXO.winner != eWinnerNone) {
        NSLog(@"%ld",(long)selectedSmallXO.winner);
        
        for (SmallXOVIewController *small in self.array) {
            [small checkWinner];
            if (small.winner == eWinnerNone ) {
                small.view.userInteractionEnabled = YES;
                small.view.superview.backgroundColor = [UIColor purpleColor];
            }else{
                small.view.userInteractionEnabled = NO;
                small.view.superview.backgroundColor = [UIColor clearColor];
            }
        }
    } else{
        for (SmallXOVIewController *small in self.array) {
            if ([small isEqual:selectedSmallXO]) {
                small.view.userInteractionEnabled = YES;
                small.view.superview.backgroundColor = [UIColor purpleColor];
            } else {
                small.view.userInteractionEnabled = NO;
                small.view.superview.backgroundColor = [UIColor clearColor];
            }
        }
    }
}


//conditions when player win the game


-(void)checkWinner{
    
    if (self.topLeft.winner == eWinnerPlayer1 && self.topCenter.winner ==  eWinnerPlayer1 && self.topRight.winner == eWinnerPlayer1) {
        [self winFirstPlayer];
    }
    else if (self.centerLeft.winner  == eWinnerPlayer1 && self.centerCenter.winner == eWinnerPlayer1 && self.centerRight.winner == eWinnerPlayer1) {
        [self winFirstPlayer];
    }
    else if (self.bottomLeft.winner == eWinnerPlayer1 && self.bottomCenter.winner == eWinnerPlayer1 && self.bottomRight.winner == eWinnerPlayer1){
        [self winFirstPlayer];
    }
    else if (self.topLeft.winner == eWinnerPlayer1 && self.centerLeft.winner == eWinnerPlayer1 && self.bottomLeft.winner == eWinnerPlayer1){
        [self winFirstPlayer];
    }
    else if (self.topCenter.winner == eWinnerPlayer1 && self.centerCenter.winner == eWinnerPlayer1 && self.bottomCenter.winner == eWinnerPlayer1){
        [self winFirstPlayer];
    }
    else if (self.topRight.winner == eWinnerPlayer1 && self.centerRight.winner == eWinnerPlayer1 && self.bottomRight.winner == eWinnerPlayer1){
        [self winFirstPlayer];
    }
    else if (self.topLeft.winner == eWinnerPlayer1 && self.centerCenter.winner == eWinnerPlayer1 && self.bottomRight.winner == eWinnerPlayer1){
        [self winFirstPlayer];
    }
    else if (self.topRight.winner == eWinnerPlayer1 && self.centerCenter.winner == eWinnerPlayer1 && self.bottomLeft.winner == eWinnerPlayer1){
        [self winSecondPlayer];
    }
    else if (self.topLeft.winner == eWinnerPlayer2 && self.topCenter.winner == eWinnerPlayer2 && self.topRight.winner == eWinnerPlayer2) {
        [self winSecondPlayer];
    }
    else if (self.centerLeft.winner == eWinnerPlayer2 && self.centerCenter.winner == eWinnerPlayer2 && self.centerRight.winner == eWinnerPlayer2) {
        [self winSecondPlayer];
    }
    else if (self.bottomLeft.winner == eWinnerPlayer2 && self.bottomCenter.winner == eWinnerPlayer2 && self.bottomRight.winner == eWinnerPlayer2){
        [self winSecondPlayer];
    }
    else if (self.topLeft.winner  == eWinnerPlayer2 && self.centerLeft.winner == eWinnerPlayer2 && self.bottomLeft.winner == eWinnerPlayer2){
        [self winSecondPlayer];
    }
    else if (self.topCenter.winner == eWinnerPlayer2 && self.centerCenter.winner == eWinnerPlayer2 && self.bottomCenter.winner == eWinnerPlayer2){
        [self winSecondPlayer];
    }
    else if (self.topRight.winner == eWinnerPlayer2 && self.centerRight.winner == eWinnerPlayer2 && self.bottomRight.winner == eWinnerPlayer2){
        [self winSecondPlayer];
    }
    else if (self.topLeft.winner == eWinnerPlayer2 && self.centerCenter.winner == eWinnerPlayer2 && self.bottomRight.winner == eWinnerPlayer2){
        [self winSecondPlayer];
    }
    else if (self.topRight.winner == eWinnerPlayer2 && self.centerCenter.winner == eWinnerPlayer2 && self.bottomLeft.winner == eWinnerPlayer2){
        [self winSecondPlayer];
    }
    else{
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)winFirstPlayer{
      self.winnerContainer.backgroundColor = [UIColor clearColor];
   self.winnerImage.image = [UIImage imageNamed:@"o"];
    self.winnerImage.backgroundColor = [UIColor clearColor];
    self.labelWinner.text = [NSString stringWithFormat:@"%@ Wins!",self.playerOneName];
    [UIView animateWithDuration:1.6 animations:^{
         NSLog(@"First Player Won");
        self.winnerContainer.hidden = NO;
        self.labelWinner.hidden = NO;
        self.labelWinner.alpha = 1;
      
        self.winnerContainer.alpha = 1;
    }];
}

-(void)winSecondPlayer{
    self.winnerContainer.backgroundColor = [UIColor clearColor];
    self.winnerImage.image = [UIImage imageNamed:@"x"];
    self.winnerImage.backgroundColor = [UIColor clearColor];
    self.labelWinner.text = [NSString stringWithFormat:@"%@ Wins!",self.playerTwoName];
    [UIView animateWithDuration:1.6 animations:^{
        NSLog(@"Second Player Won");
        self.winnerContainer.hidden = NO;
        self.labelWinner.hidden = NO;
        self.labelWinner.alpha = 1;
        self.winnerContainer.alpha = 1;
    }];
}
- (IBAction)repeatGameTapped:(id)sender {
   
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
