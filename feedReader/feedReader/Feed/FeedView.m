//
//  FeedView.m
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "FeedView.h"

@interface FeedView ()

@property (nonatomic, strong)UIView *loadingView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingSpinner;

@end

@implementation FeedView

// MARK: - Override

- (id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];

    if (self) {
        [self setupAll];
    }

    return self;
}

// MARK: - Private

- (void)setupAll {
    [self setup];
    [self setupLayer];
    [self setupConstraints];
}

- (void)setup {
    [self setupCollectionView];
    [self setupLoadingView];
    [self setupLoadingSpinner];
}

- (void)setupCollectionView {
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)setupLoadingView {
    _loadingView = [[UIView alloc] initWithFrame:CGRectZero];
    _loadingView.backgroundColor = [UIColor whiteColor];
    _loadingView.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)setupLoadingSpinner {
    _loadingSpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    _loadingSpinner.translatesAutoresizingMaskIntoConstraints = false;
    [_loadingSpinner setHidden:true];
}

- (void)setupLayer {
    [self addSubview:_collectionView];
    [self addSubview:_loadingView];
    [_loadingView addSubview:_loadingSpinner];
}

- (void)setupConstraints {
    [self setupCollectionViewConstraints];
    [self setupLoadingViewConstraints];
    [self setupLoadingSpinnerConstraints];
}

- (void)setupCollectionViewConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_collectionView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_collectionView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_collectionView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_collectionView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
}

- (void)setupLoadingViewConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_loadingView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_loadingView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_loadingView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_loadingView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
}

- (void)setupLoadingSpinnerConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_loadingView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_loadingSpinner attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_loadingView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_loadingSpinner attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}


// MARK: - Public
- (void)showLoading {
    [_loadingView setHidden:false];
    [_loadingSpinner startAnimating];
}

- (void)hideLoading {
    [_loadingView setHidden:true];
    [_loadingSpinner stopAnimating];
}

@end
