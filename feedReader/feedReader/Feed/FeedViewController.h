//
//  FeedViewController.h
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"
#import "FeedItemCell.h"
#import "FeedSectionHeader.h"
#import "FeedView.h"
#import "WebViewController.h"
#import "XMLReader.h"

@interface FeedViewController : UIViewController<UICollectionViewDataSource, FeedViewDelegate, WebViewControllerDelegate>

@end

