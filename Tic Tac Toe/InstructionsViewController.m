//
//  InstructionsViewController.m
//  Tic Tac Toe
//
//  Created by Rafał Kampa on 08.04.2015.
//  Copyright (c) 2015 Rafał Kampa. All rights reserved.
//

#import "InstructionsViewController.h"
#import "InstructionsCollectionViewCell.h"

@interface InstructionsViewController ()
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property long int pageNumber;
@property (nonatomic, strong) NSString *pageNumberString;
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@end

@implementation InstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ImagesArray = @[@"instructions_1", @"instructions_2", @"instructions_3", @"instructions_4", @"instructions_5", @"instructions_6"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.ImagesArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.pageControl.numberOfPages = self.ImagesArray.count;
    
    InstructionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InstructionCell" forIndexPath:indexPath];
    
    NSString *instructionsString = [self.ImagesArray objectAtIndex:indexPath.row];
    cell.instructionsImageView.image = [UIImage imageNamed:instructionsString];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionInstructionsImage.frame.size.width;
    float currentPage = self.collectionInstructionsImage.contentOffset.x / pageWidth;
    
    if (0.0f != fmodf(currentPage, 1.0f)){
        self.pageControl.currentPage = currentPage + 1;
    }
    else{
        self.pageControl.currentPage = currentPage;
    }
    
    self.pageNumber = self.pageControl.currentPage + 1;
    // transform long into NSString
    self.pageNumberString= [NSString stringWithFormat: @"%ld", self.pageNumber];
    NSLog(@"current page:    %@",self.pageNumberString);

    switch (self.pageControl.currentPage) {
        case 0:
            self.instructionsLabel.text = @"Each turn, you mark one of the small squares.";
            break;
        case 1:
           self.instructionsLabel.text = @"When you get three in a row on a small board, you've won that board.";
            break;
        case 2:
            self.instructionsLabel.text = @"To win the game, you need to win three small boards in a row.";
            break;
        case 3:
            self.instructionsLabel.text = @"Most important rule! You don't get to pick which of the nine boards to play on. That's determined by your opponent's previous move. Whichever square he picks, that’s the board you must play in next. (And whichever square you pick will determine which board he plays on next.) For example, if I go here...";
            break;
        case 4:
            self.instructionsLabel.text = @"Then your next move must be here...";
            break;
        case 5:
            self.instructionsLabel.text = @"What if my opponent sends me to a board that’s already been won? In that case, congratulations – you get to go anywhere you like, on any of the other boards. (This means you should avoid sending your opponent to an already-won board!)";
            break;
            
        default:
            break;
    }
}


@end
