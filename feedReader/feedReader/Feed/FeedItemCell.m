//
//  FeedItemCell.m
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "FeedItemCell.h"

@interface FeedItemCell ()

@property (nonatomic, strong) FeedItem *feedItem;
@property (nonatomic, strong) UIStackView *containerStackView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *bottomContainerView;
@property (nonatomic, strong) UIStackView *bottomStackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIActivityIndicatorView *imageLoadingSpinner;

@end

@implementation FeedItemCell

- (id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];

    if (self) {
        [self setupAll];
    }

    return self;
}

- (void)setupAll {
    [self setup];
    [self setupLayer];
    [self setupConstraints];
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 1.0;

    [self setupContainerStackView];
    [self setupImageView];
    [self setupBottomContainerView];
    [self setupBottomStackView];
    [self setupTitleLabel];
    [self setupDescriptionLabel];
    [self setupImageLoadingSpinner];
}

- (void)setupContainerStackView {
    _containerStackView = [[UIStackView alloc] init];
    _containerStackView.translatesAutoresizingMaskIntoConstraints = false;
    _containerStackView.axis = UILayoutConstraintAxisVertical;
}

- (void)setupImageView {
    _imageView = [[UIImageView alloc] init];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView setClipsToBounds:true];
}

- (void)setupBottomContainerView {
    _bottomContainerView = [[UIView alloc] init];
}

- (void)setupBottomStackView {
    _bottomStackView = [[UIStackView alloc] init];
    _bottomStackView.translatesAutoresizingMaskIntoConstraints = false;
    _bottomStackView.axis = UILayoutConstraintAxisVertical;
    _bottomStackView.spacing = 2;
}

- (void)setupTitleLabel {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
}

- (void)setupDescriptionLabel {
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
    _descriptionLabel.numberOfLines = 2;
}

- (void)setupImageLoadingSpinner {
    _imageLoadingSpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    _imageLoadingSpinner.translatesAutoresizingMaskIntoConstraints = false;
    [_imageLoadingSpinner setHidesWhenStopped:true];
}

- (void)setupLayer {
    [self.contentView addSubview:_containerStackView];
    [_containerStackView addArrangedSubview:_imageView];
    [_containerStackView addArrangedSubview:_bottomContainerView];
    [_bottomContainerView addSubview:_bottomStackView];
    [_bottomStackView addArrangedSubview:_titleLabel];
    [_bottomStackView addArrangedSubview:_descriptionLabel];
    [_imageView addSubview:_imageLoadingSpinner];
}

- (void)setupConstraints {
    [self setupContainerStackViewConstraints];
    [self setupImageLoadingSpinnerConstraints];
    [self setupBottomStackViewConstraints];
}

- (void)setupContainerStackViewConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
}

- (void)setupImageLoadingSpinnerConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_imageLoadingSpinner attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_imageLoadingSpinner attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

- (void)setupBottomStackViewConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_bottomStackView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-10.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_bottomStackView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:10.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bottomStackView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-5.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_bottomStackView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
}

// MARK: - Override
- (void)prepareForReuse {
    _feedItem = nil;
    _titleLabel.text = nil;
    _descriptionLabel.text = nil;
    _imageView.image = nil;
    [super prepareForReuse];
}

// MARK: - Helpers
- (void)showImageLoading {
    [_imageLoadingSpinner startAnimating];
}

- (void)hideImageLoading {
    [_imageLoadingSpinner stopAnimating];
}

// MARK: - Public
- (void)setFeedItem:(FeedItem *)feedItem {
    _feedItem = feedItem;
    _feedItem.delegate = self;

    _titleLabel.text = feedItem.itemTitle;
    _descriptionLabel.text = feedItem.itemDescription;

    if (feedItem.imageReady) {
        _imageView.image = feedItem.itemImage;
        [self hideImageLoading];
    } else {
        [self showImageLoading];
        [feedItem loadImageIfNeeded];
    }
}

- (void)setDescriptionHidden:(BOOL)isHidden {
    [_descriptionLabel setHidden:isHidden];
}

// MARK: - <FeedItemDelegate>
- (void)feedItem:(id)feedItem imageDidLoad:(UIImage *)image {
    _imageView.image = image;
    [self hideImageLoading];
}

@end
