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
#import "FeedItem.h"
#import "XMLReader.h"

@interface FeedViewController ()

@property (nonatomic, strong) FeedView *myView;
@property (nonatomic, strong) UIBarButtonItem *refreshButton;
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
    [self setupNavigationBar];
    [_myView.collectionView registerClass:[FeedItemCell class] forCellWithReuseIdentifier:@"feedItemCell"];
    _myView.collectionView.dataSource = self;
    [self loadData:true];
}

- (void)setupNavigationBar {
    _refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshFeed)];
    [self.navigationItem setRightBarButtonItem:_refreshButton];
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
            [weakSelf.refreshButton setEnabled:true];
            [weakSelf.myView hideLoading];
            [weakSelf.myView.collectionView reloadData];
        });
    }];

    if (showLoading) {
        [_myView showLoading];
    }
    [downloadTask resume];
}

- (void)refreshFeed {
    [_refreshButton setEnabled:false];
    [self loadData:false];
}

- (nullable NSArray *)getFeedItems:(NSDictionary *)feedData {
    id feedItemDatas = [[[feedData objectForKey:@"rss"] objectForKey:@"channel"] objectForKey:@"item"];
    if ([feedItemDatas isKindOfClass:[NSArray class]]) {
        NSMutableArray *feedItems = [NSMutableArray arrayWithCapacity:[feedItemDatas count]];
        for (int i=0; i<[feedItemDatas count]; i++) {
            if ([feedItemDatas[i] isKindOfClass:[NSDictionary class]]) {
                FeedItem *feedItem = [[FeedItem alloc] initWithDict:feedItemDatas[i]];
                [feedItems addObject:feedItem];
            } else {
                NSLog(@"Error: Invalid feed item at index %d", i);
            }
        }
        return feedItems;
    }
    NSLog(@"Error: Unable to get feed items from feed data");
    return nil;
}

- (nullable FeedItem *)getFeedItemForIndexPath:(NSIndexPath *) indexPath {
    if (_feedItems == nil || _feedItems.count == 0) {
        return nil;
    }

    id feedItem = nil;
    if (indexPath.section == 0) {
        feedItem = _feedItems[0];
    } else if (indexPath.row + 1 < _feedItems.count) {
        feedItem = _feedItems[indexPath.row + 1];
    }

    return feedItem;
}

- (void)configureFeedItemCell:(FeedItemCell *)cell indexPath:(NSIndexPath *)indexPath {
    FeedItem *feedItem = [self getFeedItemForIndexPath:indexPath];

    if (feedItem == nil) {
        return;
    }

    [cell setFeedItem:feedItem];

    if (indexPath.section == 0) {
        [cell setDescriptionHidden:false];
    } else{
        [cell setDescriptionHidden:true];
    }
}

// MARK: - <UICollectionViewDataSource>
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FeedItemCell *feedItemCell = [_myView.collectionView dequeueReusableCellWithReuseIdentifier:@"feedItemCell" forIndexPath:indexPath];
    [self configureFeedItemCell:feedItemCell indexPath:indexPath];
    return feedItemCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        // Treat most recent item as its own section
        return _feedItems == nil ? 0 : 1;
    } else {
        return _feedItems == nil ? 0 : MAX(0, _feedItems.count - 1);
    }
}

@end
