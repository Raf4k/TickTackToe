//
//  SmallXOVIewController.h
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 07.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import <UIKit/UIKit.h>

//enum integer type
typedef NS_ENUM(NSInteger, eXOPosition) {
    eXOPositionTopLeft,
    eXOPositionTopCenter,
    eXOPositionTopRight,
    eXOPositionCenterLeft,
    eXOPositionCenterCenter,
    eXOPositionCenterRight,
    eXOPositionBottomLeft,
    eXOPositionBottomCenter,
    eXOPositionBottomRight
};
typedef NS_ENUM(NSInteger, eWinner) {
    eWinnerPlayer1,
    eWinnerPlayer2,
    eWinnerPat,
    eWinnerNone
};

@class SmallXOVIewController;

@protocol SmallXODelegate <NSObject>

-(void)TouchButton:(UIButton *)button;

- (void)didSelectSmallXO:(eXOPosition)selectedXOPosition;

@end

@interface SmallXOVIewController : UIViewController

@property (weak, nonatomic) id <SmallXODelegate> delegate;
@property (assign, nonatomic) eWinner winner;

@property (weak, nonatomic) IBOutlet UIButton *topLeft;
@property (weak, nonatomic) IBOutlet UIButton *topCenter;
@property (weak, nonatomic) IBOutlet UIButton *topRight;

@property (weak, nonatomic) IBOutlet UIButton *centerLeft;
@property (weak, nonatomic) IBOutlet UIButton *centerCenter;
@property (weak, nonatomic) IBOutlet UIButton *centerRight;

@property (weak, nonatomic) IBOutlet UIButton *bottomLeft;
@property (weak, nonatomic) IBOutlet UIButton *bottomCenter;
@property (weak, nonatomic) IBOutlet UIButton *bottomRight;
@property (weak, nonatomic) IBOutlet UIImageView *winnerX;

- (IBAction)topLeftTapped:(id)sender;
-(void)checkWinner;

@end
