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
#import "XMLReader.h"

@interface FeedViewController ()

@property (nonatomic, strong) FeedView *myView;
@property (nonatomic, strong) NSArray *feedItems;

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
    [self loadData:true];
}

- (void)loadData:(BOOL)showLoading {
    NSString *feedUrl = @"https://www.personalcapital.com/blog/feed/?cat=3%2C891%2C890%2C68%2C284";
    NSURL *url = [NSURL URLWithString:feedUrl];

    __weak FeedViewController *weakSelf = self;
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
      dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        weakSelf.feedItems = [weakSelf getFeedItems:[XMLReader dictionaryForXMLData:data error:&error]];
        NSLog(@"Fetched %lu feed items", weakSelf.feedItems.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.myView hideLoading];
            [weakSelf.myView.collectionView reloadData];
        });
    }];

    if (showLoading) {
        [_myView showLoading];
    }
    [downloadTask resume];
}

- (NSArray *)getFeedItems:(NSDictionary *)feedData {
    id feedItems = [[[feedData objectForKey:@"rss"] objectForKey:@"channel"] objectForKey:@"item"];
    if ([feedItems isKindOfClass:[NSArray class]]) {
        return feedItems;
    }
    NSLog(@"Error: Unable to get feed items from feed data");
    return [NSArray array];
}

// MARK: - <UICollectionViewDataSource>
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FeedItemCell *feedItemCell = [_myView.collectionView dequeueReusableCellWithReuseIdentifier:@"feedItemCell" forIndexPath:indexPath];
    [feedItemCell setTitle:@"test 123"];
    return feedItemCell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _feedItems == nil ? 0 : _feedItems.count;
}

// MARK: - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}

@end
