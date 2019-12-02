//
//  FeedView.h
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedViewDelegate <NSObject>

- (void)feedView:(id)feedView didSelect:(NSIndexPath *)indexPath;

@end

@interface FeedView : UIView<UICollectionViewDelegateFlowLayout>

@property (nonatomic, readonly, strong) UICollectionView *collectionView;
@property (nonatomic, weak) id <FeedViewDelegate> delegate;

- (void)showLoading;
- (void)hideLoading;

@end
