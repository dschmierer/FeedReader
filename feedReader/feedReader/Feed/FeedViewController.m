//
//  FeedViewController.m
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedView.h"
#import "FeedItemCell.h"

@interface FeedViewController ()

@property (nonatomic, strong) FeedView *myView;

@end

@implementation FeedViewController

- (void)loadView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    _myView = [[FeedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.view = _myView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_myView.collectionView registerClass:[FeedItemCell class] forCellWithReuseIdentifier:@"feedItemCell"];
    _myView.collectionView.dataSource = self;
    _myView.collectionView.delegate = self;

    [_myView.collectionView reloadData];
}

// MARK: - <UICollectionViewDataSource>
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FeedItemCell *feedItemCell = [_myView.collectionView dequeueReusableCellWithReuseIdentifier:@"feedItemCell" forIndexPath:indexPath];
    [feedItemCell setTitle:@"test 123"];
    return feedItemCell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

// MARK: - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}

@end
