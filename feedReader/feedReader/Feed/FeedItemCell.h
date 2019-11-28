//
//  FeedItemCell.h
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#ifndef FeedItemCell_h
#define FeedItemCell_h


#endif /* FeedItemCell_h */

#import <UIKit/UIKit.h>

@interface FeedItemCell : UICollectionViewCell

- (void)setImageUrl:(NSURL *)imageUrl;
- (void)setTitle:(NSString *)title;
- (void)setText:(NSString *)text;

@end

