//
//  MultiplayerGameViewController.h
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 15.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiplayerGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *winnerImage;
@property (nonatomic, strong) NSString *playerOneName;
@property (nonatomic, strong) NSString *playerTwoName;
@property (weak, nonatomic) IBOutlet UIView *winnerContainer;
@end
