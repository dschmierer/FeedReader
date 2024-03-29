//
//  FeedItemCell.m
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "FeedItemCell.h"

static CGFloat const kFeedItemTitleFontSizeHandset = 12;
static CGFloat const kFeedItemTitleFontSizeTablet = 18;
static CGFloat const kFeedItemDescriptionFontSizeHandset = 10;
static CGFloat const kFeedItemDescriptionFontSizeTablet = 14;

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
    _imageView.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)setupBottomContainerView {
    _bottomContainerView = [[UIView alloc] init];
    _bottomContainerView.translatesAutoresizingMaskIntoConstraints = false;
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
    CGFloat fontSize = UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone ? kFeedItemTitleFontSizeHandset : kFeedItemTitleFontSizeTablet;
    _titleLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)setupDescriptionLabel {
    _descriptionLabel = [[UILabel alloc] init];
    CGFloat fontSize = UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone ? kFeedItemDescriptionFontSizeHandset : kFeedItemDescriptionFontSizeTablet;
    _descriptionLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightThin];
    _descriptionLabel.numberOfLines = 2;
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
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
    [self setupImageViewConstraints];
    [self setupImageLoadingSpinnerConstraints];
    [self setupBottomStackViewConstraints];
    [self setupTitleLabelConstraints];
    [self setupDescriptionLabelConstraints];
}

- (void)setupContainerStackViewConstraints {
    // Pin edges to contentView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
}

- (void)setupImageViewConstraints {
    // Allow to compress
    [_imageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
}

- (void)setupImageLoadingSpinnerConstraints {
    // Center in imageView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_imageLoadingSpinner attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_imageLoadingSpinner attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

- (void)setupBottomStackViewConstraints {
    // Pin the bottomStackView to a containerView with some padding
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_bottomStackView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-10.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_bottomStackView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:10.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bottomStackView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-5.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_bottomStackView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
}

- (void)setupTitleLabelConstraints {
    // Height should match contentSize
    [_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
}

- (void)setupDescriptionLabelConstraints {
    // Height should match contentSize
    [_descriptionLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
}

// MARK: - Override
- (void)prepareForReuse {
    if (_feedItem != nil) {
        _feedItem.delegate = nil;
        _feedItem = nil;
    }
    _titleLabel.text = nil;
    _titleLabel.numberOfLines = 0;
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

- (void)setTitleLineCount:(int)lineCount {
    [_titleLabel setNumberOfLines:lineCount];
}

// MARK: - <FeedItemDelegate>
- (void)feedItem:(id)feedItem imageDidLoad:(UIImage *)image {
    _imageView.image = image;
    [self hideImageLoading];
}

@end
