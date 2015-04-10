//
//  ViewController.h
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 07.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallXOVIewController.h"
#import "MainMenuViewController.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *winnerImage;
@property (nonatomic, strong) NSString *playerOneName;
@property (nonatomic, strong) NSString *playerTwoName;
@property (weak, nonatomic) IBOutlet UIView *winnerContainer;


@end

