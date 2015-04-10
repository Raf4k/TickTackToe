//
//  InstructionsViewController.h
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 08.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstructionsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionInstructionsImage;
@property (strong, nonatomic) NSArray *ImagesArray;

@end
