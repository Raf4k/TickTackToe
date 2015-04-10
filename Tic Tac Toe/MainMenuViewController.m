//
//  MainMenuViewController.m
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 09.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"

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
    self.enable = NO;
    self.firstPlayerName.hidden = YES;
    self.firstPlayerName.alpha = 0;
    self.secondPlayerName.alpha = 0;
    self.playButton.alpha = 0;
    self.secondPlayerName.hidden = YES;
    self.playButton.hidden = YES;
    
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ViewController class]]) {
        ViewController *vc = segue.destinationViewController;
        vc.playerOneName = self.firstPlayerName.text;
        vc.playerTwoName = self.secondPlayerName.text;
    }
    
}

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



@end
