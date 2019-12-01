//
//  FeedView.h
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#ifndef FeedView_h
#define FeedView_h


#endif /* FeedView_h */

#import <UIKit/UIKit.h>

@interface FeedView : UIView

@property (nonatomic, readonly, strong) UICollectionView *collectionView;

- (void)showLoading;
- (void)hideLoading;

@end
