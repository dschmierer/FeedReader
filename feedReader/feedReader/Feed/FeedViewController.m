//
//  FeedViewController.m
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "FeedViewController.h"
#import <SafariServices/SafariServices.h>

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
    _myView.delegate = self;
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
        NSDictionary *feedData = [XMLReader dictionaryForXMLData:data error:&error];
        weakSelf.feedItems = [weakSelf getFeedItems:feedData];
        NSLog(@"Fetched %lu feed items", weakSelf.feedItems.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.title = [weakSelf getFeedTitle:feedData];
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

- (NSString *)getFeedTitle:(NSDictionary *)feedData {
    id feedTitle = [[[[feedData objectForKey:@"rss"] objectForKey:@"channel"] objectForKey:@"title"] objectForKey:@"text"];

    if ([feedTitle isKindOfClass:[NSString class]]) {
        return [[feedTitle stringByRemovingPercentEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    NSLog(@"Error: Unable to get feed title from feed data");
    return @"";
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
        [cell setTitleLineCount:1];
    } else{
        [cell setDescriptionHidden:true];
        [cell setTitleLineCount:2];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [_myView.collectionView.collectionViewLayout invalidateLayout];
}

// MARK: - <WebViewControllerDelegate>
- (void)webViewControllerDonePressed:(id)webViewController {
    [[self presentedViewController] dismissViewControllerAnimated:true completion:nil];
}

// MARK: - <FeedViewDelegate>
- (void)feedView:(id)feedView didSelect:(NSIndexPath *)indexPath {
    FeedItem *feedItem = [self getFeedItemForIndexPath:indexPath];

    if (feedItem == nil) {
        return;
    }

    WebViewController *vc = [[WebViewController alloc] initWithURL:feedItem.itemUrl title:feedItem.itemTitle];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    nvc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:nvc animated:true completion:nil];
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
