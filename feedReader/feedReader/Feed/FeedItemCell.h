//
//  FeedItemCell.h
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"

@interface FeedItemCell : UICollectionViewCell<FeedItemDelegate>

@property (readonly) FeedItem *feedItem;

- (void)setFeedItem:(FeedItem *)feedItem;
- (void)setDescriptionHidden:(BOOL)isHidden;

@end

